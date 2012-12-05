module Exlibris
  module Primo
    #
    #
    #
    class Tags
      # Config::Attributes need to be first because of inheritance
      # of Ruby modules. This is a shitty, shitty hack.
      include Config::Attributes
      include BaseAttributes
      include RequestAttributes
      include WriteAttributes

      attr_accessor :user_id, :record_id

      def initialize *args
        super
      end

      #
      # Call web service to get my tags
      #
      def my_tags
        @my_tags ||= get_tags.my_tags
      end

      def everybody_tags
        @my_tags ||= get_tags.everybody_tags
      end

      def get_tags
        @get_tags ||= Exlibris::Primo::WebService::Request::GetTags.new(user_record_request_attributes).call
      end
      private :get_tags
    end
  end
end