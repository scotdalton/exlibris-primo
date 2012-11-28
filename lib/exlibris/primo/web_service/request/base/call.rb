module Exlibris
  module Primo
    module WebService
      module Request
        module Call
          # 
          # Returns an response Exlibris::Primo::WebService::Response that corresponds
          # to the request.
          # 
          def call
            # Get the Response class that matches the Request class.
            response_klass = "Exlibris::Primo::WebService::Response::#{self.class.name.demodulize}".constantize
            response_klass.new(client.send(soap_action, to_xml), soap_action)
          end
        end
      end
    end
  end
end