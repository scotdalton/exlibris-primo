module Exlibris
  module Primo
    #
    #
    #
    class FacetValue
      include Config::Attributes
      include Namespaces
      include WriteAttributes
      include XmlUtil

      def initialize *args
        @raw_xml = args.last.delete(:raw_xml)
        super
      end

      def name
        @name ||= xml.root["KEY"]
      end

      def count
        @count ||= xml.root["VALUE"]
      end
    end
  end
end