module Exlibris
  module Primo
    # 
    # 
    # 
    class Facet
      include Config::Attributes
      include MissingResponse
      include Namespaces
      include WriteAttributes
      include XmlUtil

      attr_accessor :accurate
      alias accurate? accurate

      def initialize *args
        @raw_xml = args.last.delete(:raw_xml)
        super
      end

      def name
        @name = xml.root["NAME"]
      end

      def count
        @count = xml.root["COUNT"]
      end

      def facet_values
        @facet_values ||= xml.root.search("//FACET_VALUES").collect do |facet_value|
          FacetValue.new(:raw_xml => facet_value.to_xml)
        end
      end
    end
  end
end