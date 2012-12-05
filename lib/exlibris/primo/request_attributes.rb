module Exlibris
  module Primo
    module RequestAttributes
      def request_attributes
        @request_attributes ||= {:base_url => base_url, :institution => institution}
      end
      protected :request_attributes

      def user_request_attributes
        @user_request_attributes ||= request_attributes.merge :user_id => user_id
      end
      protected :user_request_attributes

      def user_record_request_attributes
        @user_record_request_attributes ||= user_request_attributes.merge :doc_id => record_id
      end
      protected :user_record_request_attributes
    end
  end
end