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
            response_klass.new(client.send(action, to_xml), action)
          end
        end
      end
    end
  end
end