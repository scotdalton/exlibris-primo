module Exlibris
  module Primo
    module WebService
      module Request
        module SortBys
          # 
          # Returns a lambda that takes a Nokogiri::XML::Builder as an argument
          # and appends sort bys XML to it.
          # 
          def sort_bys_xml
            lambda { |xml|
              xml.SortByList {
                sort_bys.each do |sort_by|
                  xml.SortField sort_by
                end
              } unless sort_bys.empty?
            }
          end
          protected :sort_bys_xml

          def sort_bys
            @sort_bys ||= []
          end

          def add_sort_by(sort_by)
            sort_bys << sort_by
          end
        end
      end
    end
  end
end