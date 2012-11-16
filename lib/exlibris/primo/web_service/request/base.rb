module Exlibris
  module Primo
    module WebService
      module Request
        class Base
          extend Abstract
          include BaseElements
          include Core
          include ToXml
          include Util
          self.abstract = true
          self.add_base_elements :institution, :ip, :group, 
            :on_campus, :is_logged_in, :pds_handle
        end

        class User < Base
          # Add user_id to the base elements
          self.add_base_elements :user_id
          self.abstract = true
        end

        class Record < Base
          # Add doc_id to the base elements
          self.add_base_elements :doc_id
          self.abstract = true
        end

        class UserRecord < Record
          # Add user_id to the base elements
          self.add_base_elements :user_id
          self.abstract = true
        end
      end
    end
  end
end