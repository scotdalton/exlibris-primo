module Exlibris
  module Primo
    module WebService
      module Client
        # 
        # 
        # 
        class Eshelf < Base
          self.add_soap_actions :get_eshelf, :add_to_eshelf, :remove_from_eshelf, 
            :add_folder_to_eshelf, :remove_folder_from_eshelf
        end

        # 
        # 
        # 
        class EshelfStructure < Base
          self.add_soap_actions :get_eshelf_structure
        end
      end
    end
  end
end