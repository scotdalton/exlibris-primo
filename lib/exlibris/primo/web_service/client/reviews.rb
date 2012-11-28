module Exlibris
  module Primo
    module WebService
      module Client
        # 
        # 
        # 
        class Reviews < Base
          self.add_soap_actions :get_reviews, :get_all_my_reviews, :get_reviews_for_record, 
            :get_reviews_by_rating, :add_review, :remove_review
        end
      end
    end
  end
end