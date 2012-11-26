module Exlibris
  module Primo
    module WebService
      module Response
        module Hits
          attr_reader :hits
          alias :count :hits

          def initialize *args
            super
            @hits = xml.at("//search:DOCSET", response_namespaces)["TOTALHITS"]
          end
        end
      end
    end
  end
end