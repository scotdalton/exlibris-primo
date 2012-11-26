module Exlibris
  module Primo
    module WebService
      module Response
        
        # 
        # 
        # 
        class Search < Base
          include Facets
          include Hits
          include Records
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