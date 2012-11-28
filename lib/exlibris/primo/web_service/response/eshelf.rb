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
        class GetEshelfStructure < Eshelf; end

        # 
        # 
        # 
        class GetEshelf < Eshelf;
          include DidUMean
          include Records
          include SearchStats
        end

        # 
        # 
        # 
        class AddToEshelf < Eshelf; end

        # 
        # 
        # 
        class RemoveFromEshelf < Eshelf; end

        # 
        # 
        # 
        class AddFolderToEshelf < Eshelf; end

        # 
        # 
        # 
        class RemoveFolderFromEshelf < Eshelf; end
      end
    end
  end
end