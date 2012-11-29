module Exlibris
  module Primo
    #
    #
    #
    class Reviews
      include Config::Attributes
      include RequestAttributes
      include WriteAttributes

      attr_accessor :user_id, :record_id

      def initialize *args
        super
      end

      #
      # Call web service to get reviews
      #
      def reviews
        @reviews ||= Exlibris::Primo::WebService::Request::GetReviews.new(user_record_request_attributes).call.reviews
      end
    end
  end
end