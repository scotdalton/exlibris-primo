module Exlibris
  module Primo
    module WebService
      module Response
        module SearchStats
          def total_time
            @total_time ||= search_set["TOTAL_TIME"] if search_set
          end
          alias :time :total_time

          def hit_time
            @hit_time ||= search_set["HIT_TIME"] if search_set
          end
          alias :search_time :hit_time

          def total_hits
            @total_hits ||= search_set["TOTALHITS"] if search_set
          end
          alias :hits :total_hits
          alias :count :total_hits

          def first_hit
            @first_hit ||= search_set["FIRSTHIT"] if search_set
          end

          def last_hit
            @last_hit ||= search_set["LASTHIT"] if search_set
          end

          def local?
            @local ||= parse_local(search_set["IS_LOCAL"]) if search_set
          end

          def parse_local local
            (local.eql? "true") if local
          end
          protected :parse_local

          def search_set
            @search_set ||= xml.at_xpath("//search:DOCSET", response_namespaces)
          end
          protected :search_set
        end
      end
    end
  end
end