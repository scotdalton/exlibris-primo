module Exlibris
  module Primo
    class FacetValue
      include Config::Attributes
      include MissingResponse
      include Namespaces
      include WriteAttributes
      include XmlUtil

      #
      #
      #
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

      #
      #
      #
      def url
        @url ||= "#{base_url}/primo_library/libweb/action/dlDisplay.do?dym=false&onCampus=false&docId=#{record_id}&institution=#{institution}&vid=#{vid}"
      end
    end
  end
end