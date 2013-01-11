module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # Abstract class for eshelf interaction
        # 
        class Eshelf < UserBase
          self.add_base_elements :folder_id
          self.abstract = true
          self.has_client
        end

        # 
        # Abstract class for eshelf record interaction
        # 
        class EshelfRecord < Eshelf
          self.add_base_elements :doc_id
          self.abstract = true
        end

        # 
        # Abstract class for eshelf structure interaction
        # 
        class EshelfStructure < Eshelf
          self.add_base_elements :include_basket_items
          self.has_client
          self.abstract = true
        end

        # 
        # Get eshelf structure from Primo for a specified user
        # 
        class GetEshelfStructure < EshelfStructure; end

        # 
        # Get eshelf from Primo for a specified user
        # 
        class GetEshelf < Eshelf
          self.add_base_elements :get_delivery
        end

        # 
        # Add given record to Primo for a specified user
        # 
        class AddToEshelf < EshelfRecord
          self.add_base_elements :searchkey
          self.remove_base_elements :folder_id
        end

        # 
        # Remove given record from Primo for a specified user
        # 
        class RemoveFromEshelf < EshelfRecord; end

        # 
        # Add given folder name to Primo for a specified user
        # 
        class AddFolderToEshelf < Eshelf
          self.add_base_elements :folder_name, :parent_folder
          self.remove_base_elements :folder_id
        end

        # 
        # Remove given folder from Primo for a specified user
        # 
        class RemoveFolderFromEshelf < Eshelf; end
      end
    end
  end
end