module Exlibris
  module Primo
    module WebService
      module Response
        
        # 
        # 
        # 
        class Search < Base
          include DidUMean
          include Facets
          include Records
          include SearchStats
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