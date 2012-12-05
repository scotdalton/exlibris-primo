module Exlibris
  module Primo
    #
    #
    #
    class Reviews
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
      # Call web service to get reviews
      #
      def reviews
        @reviews ||= Exlibris::Primo::WebService::Request::GetReviews.new(user_record_request_attributes).call.reviews
      end
    end
  end
end