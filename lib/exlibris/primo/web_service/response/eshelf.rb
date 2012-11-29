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
        class GetEshelfStructure < Eshelf
          def basket_id
            @basket_id ||= basket_folder["folder_id"]
          end

          def basket_folder
            @basket_folder ||= folders.at_xpath("//eshelf:eshelf_folder[./eshelf:folder_name='Basket']", response_namespaces)
          end

          def folders
            @folders ||= xml.xpath("//eshelf:eshelf_folders", response_namespaces)
          end
        end

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