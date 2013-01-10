module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # Abstract class for reviews interaction
        # 
        class Reviews < UserRecord
          self.abstract = true
          self.has_client
        end
        
        # 
        # Get reviews from from Primo for a specified user
        # and record
        # 
        class GetReviews < Reviews; end

        # 
        # Get all reviews for a specified user from Primo
        # 
        class GetAllMyReviews < Reviews
          self.remove_base_elements :doc_id
        end

        # 
        # Get reviews for a specified record from Primo
        # 
        class GetReviewsForRecord < Reviews
          self.remove_base_elements :user_id
        end

        # 
        # Get reviews of a given rating for a specified user from Primo
        # 
        class GetReviewsByRating < Reviews
          self.add_base_elements :rating
          self.remove_base_elements :doc_id
        end

        # 
        # Add given review to Primo for a specified record and user
        # 
        class AddReview < Reviews
          # Add review elements to the base elements
          self.add_base_elements :value, :rating, :user_display_name, 
            :allow_user_name, :status
        end

        # 
        # Remove review from Primo for a specified record and user
        # 
        class RemoveReview < Reviews; end
      end
    end
  end
end