module Exlibris
  module Primo
    module WebService
      module Response
        # 
        # 
        # 
        class Tags < Base
          self.abstract = true
        end

        # 
        # 
        # 
        class GetTags < Tags; end

        # 
        # 
        # 
        class GetAllMyTags < Tags; end

        # 
        # 
        # 
        class GetTagsForRecord < Tags; end

        # 
        # 
        # 
        class RemoveTag < Tags; end

        # 
        # 
        # 
        class GetUserTags < Tags; end
      end
    end
  end
end