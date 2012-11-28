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
            # @record = records.first.last
            @local = parse_local(search_doc["LOCAL"]) if search_doc
          end

          def search_doc
            xml.at_xpath("//search:DOC", response_namespaces)
          end
        end
      end
    end
  end
end