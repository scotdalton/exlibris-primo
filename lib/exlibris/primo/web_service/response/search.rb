module Exlibris
  module Primo
    module WebService
      module Response
        
        # 
        # 
        # 
        class Search < Base
          include Records
          include Facets
          attr_reader :hits

          def initialize *args
            super
            @hits = xml.at("//search:DOCSET", response_namespaces)["TOTALHITS"]
          end
        end

        # 
        # 
        # 
        class FullView < Search
          attr_reader :record

          def initialize *args
            super
            @record = records.first
          end
        end
      end
    end
  end
end