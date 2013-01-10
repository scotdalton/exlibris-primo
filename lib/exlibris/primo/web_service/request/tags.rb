module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # Abstract class for tags interaction
        # 
        class Tags < UserRecord
          self.abstract = true
          self.has_client
        end

        # 
        # Get tags from from Primo for a specified user
        # and record
        # 
        class GetTags < Tags; end

        # 
        # Get all tags for a specified user from Primo
        # 
        class GetAllMyTags < Tags
          self.remove_base_elements :doc_id
        end

        # 
        # Get tags for a specified record from Primo
        # 
        class GetTagsForRecord < Tags
          self.remove_base_elements :user_id
        end

        # 
        # Add given tag to Primo for a specified record and user
        # 
        class AddTag < Tags
          self.add_base_elements :value
        end

        # 
        # Remove given tag from Primo for a specified record and user
        # 
        class RemoveTag < Tags
          self.add_base_elements :value
        end

        # 
        # Remove all tags from Primo for a specified user
        # 
        class RemoveUserTags < Tags
          self.remove_base_elements :doc_id
        end
      end
    end
  end
end