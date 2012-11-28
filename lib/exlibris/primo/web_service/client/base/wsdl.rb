module Exlibris
  module Primo
    module WebService
      module Client
        module Wsdl
          def wsdl
            @wsdl ||= "#{endpoint}?wsdl"
          end
          protected :wsdl
        end
      end
    end
  end
end