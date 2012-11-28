module Exlibris
  module Primo
    module WebService
      module Client
        # 
        # 
        # 
        class Tags < Base
          self.add_soap_actions :get_tags, :get_all_my_tags, :get_tags_for_record, :remove_tag, :remove_user_tags
        end
      end
    end
  end
end