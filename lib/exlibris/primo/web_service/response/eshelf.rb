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
        # The eshelf structure action is not specified in Primo's WSDL and 
        # is therefore not supported for the time being.
        # 
        class EshelfStructure < Eshelf
        end

        # 
        # 
        # 
        class AddFolderToEshelf < Eshelf; end

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
      end
    end
  end
end