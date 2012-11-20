module Exlibris
  module Primo
    module WebService
      module Response
        module Util
          def response_key
            "#{action}_response".to_sym
          end
          protected :response_key
          
          def return_key
            "#{action}_return".to_sym
          end
          protected :response_key
        end
      end
    end
  end
end