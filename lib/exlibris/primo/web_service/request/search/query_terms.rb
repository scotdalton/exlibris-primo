module Exlibris
  module Primo
    module WebService
      module QueryTerms

        def query_terms_xml(bool_operator="AND")
          build_xml do |xml|
            xml.QueryTerms {
              xml.BoolOpeator bool_operator
              query_terms.each do |query_term|
                xml << query_term.to_xml
              end
            }
          end
        end
        protected :query_terms_xml

        def query_terms
          @query_terms ||= []
        end

        def add_query_term(value, index, precision="contains")
          query_terms << QueryTerm.new(:value => value, :index => index, :precision => precision)
        end
      end
    end
  end
end