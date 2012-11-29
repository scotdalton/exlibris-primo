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
        class GetReviews < Reviews
          def reviews
            @reviews ||= xml.root.xpath("//tags_reviews:Review", response_namespaces).collect { |review|
                Exlibris::Primo::Review.new(:raw_xml => review.to_xml) }
          end
        end

        # 
        # 
        # 
        class GetAllMyReviews < GetReviews; end

        # 
        # 
        # 
        class GetReviewsForRecord < GetReviews; end

        # 
        # 
        # 
        class GetReviewsByRating < GetReviews; end

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