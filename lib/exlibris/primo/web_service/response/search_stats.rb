module Exlibris
  module Primo
    module WebService
      module Response
        module SearchStats
          attr_reader :time, :hits, :local
          alias :count :hits
          alias :local? :local

          def initialize *args
            super
            unless docset.nil?
              @time = docset["TOTAL_TIME"]
              @hits = docset["TOTALHITS"]
              @local = (docset["IS_LOCAL"].eql? "true")
            end
          end
          
          def docset
            @docset ||= xml.at_xpath("//search:DOCSET", response_namespaces)
          end
          private :docset
        end
      end
    end
  end
end