module Exlibris
  module Primo
    module WebService
      module Response
        module DidUMean
          def did_u_mean
            @did_u_mean ||= 
              xml.at_xpath("//search:QUERYTRANSFORM[@ACTION='did_u_mean']", response_namespaces)["QUERY"].strip
          end
        end
      end
    end
  end
end