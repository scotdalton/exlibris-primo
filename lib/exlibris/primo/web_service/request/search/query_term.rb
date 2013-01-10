module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # 
        # 
        class QueryTerm
          include WriteAttributes
          include XmlUtil
          attr_accessor :index, :precision, :value
          attr_writer :include_values, :exclude_values
          
          def include_values
            @include_values ||= []
          end

          def exclude_values
            @exclude_values ||= []
          end

          def to_xml
            include_values = self.include_values
            exclude_values = self.exclude_values
            build_xml do |xml|
              xml.QueryTerm {
                xml.IndexField index
                xml.PrecisionOperator precision
                xml.Value value
                include_values.each do |include_value|
                  xml.includeValue include_value
                end
                exclude_values.each do |exclude_value|
                  xml.excludeValue exclude_value
                end
              }
            end
          end
        end
      end
    end
  end
end