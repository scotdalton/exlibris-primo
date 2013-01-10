module Exlibris
  module Primo
    module WebService
      module Response
        module DidUMean
          def did_u_mean
            @did_u_mean ||= querytransform["QUERY"].strip unless querytransform.nil?
          end
          
          def querytransform
            @querytransform ||= xml.at_xpath("//search:QUERYTRANSFORM[@ACTION='did_u_mean']", response_namespaces)
          end
        end
      end
    end
  end
end