module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # 
        # 
        class Search < Base
          self.has_client
          self.soap_action = :search_brief
          include Locations
          include QueryTerms
          include SearchElements

          def to_xml
            super { |xml|
              xml.PrimoSearchRequest("xmlns" => "http://www.exlibris.com/primo/xsd/search/request") {
                xml << query_terms_xml
                xml << search_elements_xml
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
          self.soap_action = :get_record
        end
      end
    end
  end
end