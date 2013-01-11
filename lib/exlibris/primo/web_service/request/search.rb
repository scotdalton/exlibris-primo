module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # Search Primo
        # 
        class Search < Exlibris::Primo::WebService::Request::Base
          self.has_client
          self.soap_action = :search_brief
          include DisplayFields
          include Languages
          include Locations
          include QueryTerms
          include SearchElements
          include SortBys

          add_default_search_elements :start_index => "1", 
            :bulk_size => "5", :did_u_mean_enabled => "false"

          add_search_elements :start_index, :bulk_size, :did_u_mean_enabled,
              :highlighting_enabled, :get_more, :inst_boost

          def to_xml
            super { |xml|
              xml.PrimoSearchRequest("xmlns" => "http://www.exlibris.com/primo/xsd/search/request") {
                query_terms_xml.call xml
                search_elements_xml.call xml
                languages_xml.call xml
                sort_bys_xml.call xml
                display_fields_xml.call xml
                locations_xml.call xml
              }
            }
          end
        end

        # 
        # Get a specific record from Primo.
        # 
        class FullView < Exlibris::Primo::WebService::Request::Search
          # Add doc_id to the base elements
          self.add_base_elements :doc_id
          self.soap_action = :get_record
        end
      end
    end
  end
end