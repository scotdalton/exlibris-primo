module Exlibris
  module Primo
    module WebService
      module Response
        # 
        # 
        # 
        class Reviews < Base
          self.abstract = true
        end

        # 
        # 
        # 
        class GetReviews < Reviews; end

        # 
        # 
        # 
        class GetAllMyReviews < Reviews; end

        # 
        # 
        # 
        class GetReviewsForRecord < Reviews; end

        # 
        # 
        # 
        class GetReviewsByRating < Reviews; end

        # 
        # 
        # 
        class AddReview < Reviews; end

        # 
        # 
        # 
        class RemoveReview < Reviews; end
      end
    end
  end
end