module Exlibris
  module Primo
    #
    # Primo Tag
    #
    class Tag
      include Config::Attributes
      include Namespaces
      include WriteAttributes
      include XmlUtil

      def initialize *args
        @raw_xml = args.last.delete(:raw_xml)
        super
      end

      def user_id
        @user_id = xml.root.at_xpath("//userId").inner_text
      end

      def record_id
        @record_id = xml.root.at_xpath("//docId").inner_text
      end

      def status
        @status = xml.root.at_xpath("//status").inner_text
      end

      def value
        @value = xml.root.at_xpath("//value").inner_text
      end
    end
  end
end