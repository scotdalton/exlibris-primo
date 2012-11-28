module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # 
        # 
        class Eshelf < User
          self.add_base_elements :folder_id
          self.abstract = true
          self.has_client
        end

        # 
        # 
        # 
        class EshelfRecord < Eshelf
          self.add_base_elements :doc_id
          self.abstract = true
        end

        # 
        # 
        # 
        class EshelfStructure < Eshelf
          self.add_base_elements :include_basket_items
          self.has_client
          self.abstract = true
        end

        # 
        # 
        # 
        class GetEshelfStructure < EshelfStructure; end

        # 
        # 
        # 
        class GetEshelf < Eshelf
          self.add_base_elements :get_delivery
        end

        # 
        # 
        # 
        class AddToEshelf < EshelfRecord
          self.add_base_elements :searchkey
          self.remove_base_elements :folder_id
        end

        # 
        # 
        # 
        class RemoveFromEshelf < EshelfRecord; end

        # 
        # 
        # 
        class AddFolderToEshelf < Eshelf
          self.add_base_elements :folder_name, :parent_folder
          self.remove_base_elements :folder_id
        end

        # 
        # 
        # 
        class RemoveFolderFromEshelf < Eshelf; end
      end
    end
  end
end