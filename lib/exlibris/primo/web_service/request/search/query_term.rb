module Exlibris
  module Primo
    module WebService
      module Request
        class QueryTerm
          include WriteAttributes
          include XmlUtil
          attr_accessor :index, :precision, :value
        
          def to_xml
            build_xml do |xml|
              xml.QueryTerm {
                xml.IndexField index
                xml.PrecisionOperator precision
                xml.Value value
              }
            end
          end
        end
      end
    end
  end
end