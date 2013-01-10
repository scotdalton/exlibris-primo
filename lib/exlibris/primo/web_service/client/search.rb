module Exlibris
  module Primo
    module WebService
      module Client
        # 
        # 
        # 
        class Search < Base
          self.endpoint = :searcher
          self.add_soap_actions :search_brief, :get_record
        end
      end
    end
  end
end