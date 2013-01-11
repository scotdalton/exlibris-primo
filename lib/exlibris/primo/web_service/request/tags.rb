module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # Abstract class for tags interaction
        # 
        class Tags < Exlibris::Primo::WebService::Request::UserRecord
          self.abstract = true
          self.has_client
        end

        # 
        # Get tags from from Primo for a specified user
        # and record
        # 
        class GetTags < Exlibris::Primo::WebService::Request::Tags; end

        # 
        # Get all tags for a specified user from Primo
        # 
        class GetAllMyTags < Exlibris::Primo::WebService::Request::Tags
          self.remove_base_elements :doc_id
        end

        # 
        # Get tags for a specified record from Primo
        # 
        class GetTagsForRecord < Exlibris::Primo::WebService::Request::Tags
          self.remove_base_elements :user_id
        end

        # 
        # Add given tag to Primo for a specified record and user
        # 
        class AddTag < Exlibris::Primo::WebService::Request::Tags
          self.add_base_elements :value
        end

        # 
        # Remove given tag from Primo for a specified record and user
        # 
        class RemoveTag < Exlibris::Primo::WebService::Request::Tags
          self.add_base_elements :value
        end

        # 
        # Remove all tags from Primo for a specified user
        # 
        class RemoveUserTags < Exlibris::Primo::WebService::Request::Tags
          self.remove_base_elements :doc_id
        end
      end
    end
  end
end