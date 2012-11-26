module Exlibris
  module Primo
    module WebService
      module Response
        # 
        # 
        # 
        class Eshelf < Base
          self.abstract = true
        end

        # 
        # 
        # 
        class EshelfStructure < Eshelf; end

        # 
        # 
        # 
        class AddFoldertoEshelf < Eshelf; end

        # 
        # 
        # 
        class GetEshelf < Eshelf;
          include Hits
          include Records
        end

        # 
        # 
        # 
        class AddToEshelf < Eshelf; end

        # 
        # 
        # 
        class RemoveFromEshelf < Eshelf; end
      end
    end
  end
end