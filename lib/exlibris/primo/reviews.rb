module Exlibris
  module Primo
    #
    # Manipulate a Primo reviews using Exlibris::Primo::Reviews
    # 
    #     reviews = Reviews.new.base_url!("http://primo.library.edu").institution!("PRIMO").
    #       user_id!("USER_ID").record_id!("aleph0123456789")
    #     reviews.reviews #=> Array of Primo reviews
    #
    class Reviews
      include Config::Attributes
      include ChainGang::Base
      include ChainGang::User
      include ChainGang::Record
      include RequestAttributes
      include WriteAttributes

      attr_reader :user_id, :record_id

      def initialize *args
        super
      end

      #
      # Call web service to get reviews for the specified user and record
      #
      def reviews
        @reviews ||= Exlibris::Primo::WebService::Request::GetReviews.
          new(user_record_request_attributes).call.reviews
      end

      # 
      # Call web service to get all reviews for the specified user
      # 
      def user_reviews
        @user_reviews ||= Exlibris::Primo::WebService::Request::GetAllMyReviews.
          new(user_request_attributes).call.reviews
      end

      # 
      # Call web service to get all reviews for the specified record
      # 
      def record_reviews
        @record_reviews ||= Exlibris::Primo::WebService::Request::GetReviewsForRecord.
          new(record_request_attributes).call.reviews
      end

      # 
      # Get the reviews of a certain rating for the specified user
      # 
      def rating_reviews(rating)
        Exlibris::Primo::WebService::Request::GetReviewsByRating.
          new(user_request_attributes.merge :rating => rating).call.reviews
      end

      #
      # Call web service to add a review to Primo for the specified record
      #
      def add_review(value, rating, user_display_name, status, allow_user_name = true)
        Exlibris::Primo::WebService::Request::AddReview.
          new(user_record_request_attributes.merge :value => value, :rating => rating, 
            :user_display_name => user_display_name, :status =>status, :allow_user_name => allow_user_name).call
      end

      #
      # Call web service to remove review from Primo for the specified record
      #
      def remove_review
        Exlibris::Primo::WebService::Request::RemoveReview.
          new(user_record_request_attributes).call
      end
    end
  end
end