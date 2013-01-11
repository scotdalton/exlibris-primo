module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # Abstract class for reviews interaction
        # 
        class Reviews < Exlibris::Primo::WebService::Request::UserRecord
          self.abstract = true
          self.has_client
        end
        
        # 
        # Get reviews from from Primo for a specified user
        # and record
        # 
        class GetReviews < Exlibris::Primo::WebService::Request::Reviews; end

        # 
        # Get all reviews for a specified user from Primo
        # 
        class GetAllMyReviews < Exlibris::Primo::WebService::Request::Reviews
          self.remove_base_elements :doc_id
        end

        # 
        # Get reviews for a specified record from Primo
        # 
        class GetReviewsForRecord < Exlibris::Primo::WebService::Request::Reviews
          self.remove_base_elements :user_id
        end

        # 
        # Get reviews of a given rating for a specified user from Primo
        # 
        class GetReviewsByRating < Exlibris::Primo::WebService::Request::Reviews
          self.add_base_elements :rating
          self.remove_base_elements :doc_id
        end

        # 
        # Add given review to Primo for a specified record and user
        # 
        class AddReview < Exlibris::Primo::WebService::Request::Reviews
          # Add review elements to the base elements
          self.add_base_elements :value, :rating, :user_display_name, 
            :allow_user_name, :status
        end

        # 
        # Remove review from Primo for a specified record and user
        # 
        class RemoveReview < Exlibris::Primo::WebService::Request::Reviews; end
      end
    end
  end
end