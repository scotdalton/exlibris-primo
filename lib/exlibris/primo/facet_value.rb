module Exlibris
  module Primo
    require 'iso-639'
    #
    # Primo facet value that holds the name of the value
    # and the number of records that limiting by this facet
    # value would return.
    #
    class FacetValue
      include Config::Attributes
      include WriteAttributes
      include XmlUtil

      attr_accessor :facet

      def initialize *args
        @raw_xml = args.last.delete(:raw_xml)
        super
      end

      def name
        @name ||= xml.root["KEY"]
      end

      def display_name
        return @display_name ||= (ISO_639.find(name).english_name || name) if facet.name.eql? "lang"
        return @display_name ||= (config.libraries[name] || name) if facet.name.eql? "library"
        return @display_name ||= (config.facet_top_level[name] || name) if facet.name.eql? "tlevel"
        return @display_name ||= (config.facet_collections[name] || name) if facet.name.eql? "domain"
        return @display_name ||= (config.facet_resource_types[name] || name) if facet.name.eql? "rtype"
        @display_name ||= name
      end

      def size
        @size = Integer(xml.root["VALUE"])
      end
      alias :count :size
    end
  end
end