module Exlibris
  module Primo
    #
    #
    #
    class Review
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

      def rating
        @rating = xml.root.at_xpath("//rating").inner_text
      end

      def status
        @status = xml.root.at_xpath("//status").inner_text
      end

      def value
        @value = xml.root.at_xpath("//value").inner_text
      end

      def user_display_name
        @user_display_name = xml.root.at_xpath("//userDisplayName").inner_text
      end

      def allow_user_name?
        @allow_user_name = (xml.root.at_xpath("//allowUserName").inner_text.eql? "true")
      end
    end
  end
end