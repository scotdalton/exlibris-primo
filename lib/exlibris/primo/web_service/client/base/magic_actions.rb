module Exlibris
  module Primo
    module WebService
      module Client
        module MagicActions
          # 
          # Define methods for SOAP actions. SOAP actions take a single String argument, request_xml,
          # which is set as the body of the SOAP request
          # 
          def method_missing(method, *args, &block)
            if(client.wsdl.soap_action method)
              self.class.send(:define_method, method) { |request_xml|
                client.request(method) { soap.body = request_xml }
              }
              send method, *args, &block
            else
              super
            end
          end

          #
          # Tell users that we respond to SOAP actions.
          #
          def respond_to?(method, include_private=false)
            (client.wsdl.soap_action(method) || super) ? true : false
          end
        end
      end
    end
  end
end