module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # 
        # 
        class Search < Base
          self.has_client
          self.action = :search_brief
          include QueryTerms
          include SearchElements

          def to_xml
            super { |xml|
              xml.PrimoSearchRequest("xmlns" => "http://www.exlibris.com/primo/xsd/search/request") {
                xml << query_terms
                xml << search_elements
              }
            }
          end
        end

        # 
        # 
        # 
        class FullView < Search
          # Add doc_id to the base elements
          self.add_base_elements :doc_id
          # Clear the query terms since record searches don't do queries on terms.
          self.query_terms.clear
          self.action = :get_record
        end
      end
    end
  end
end