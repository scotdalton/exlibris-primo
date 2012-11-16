module Exlibris
  module Primo
    module WebService
      module Request
        class Reviews < UserRecord
          self.abstract = true
        end
        
        # 
        # 
        # 
        class GetReviews < Reviews; end

        # 
        # 
        # 
        class GetAllMyReviews < Reviews
          self.remove_base_elements :doc_id
        end

        # 
        # 
        # 
        class GetReviewsForRecord < Reviews
          self.remove_base_elements :user_id
        end

        # 
        # 
        # 
        class GetReviewsByRating < Reviews
          self.add_base_elements :rating
          self.remove_base_elements :doc_id
        end

        # 
        # 
        # 
        class AddReview < Reviews
          # Add review elements to the base elements
          self.add_base_elements :value, :rating, :user_display_name, 
            :allow_user_name, :status
        end

        # 
        # 
        # 
        class RemoveReview < Reviews; end
      end
    end
  end
end