module Exlibris
  module Primo
    module WebService
      module MagicActions
        # Leverage ActiveSupport core extensions
        require 'active_support/core_ext'

        # 
        # Define methods for SOAP actions.  SOAP actions take a single argument, request,
        # which must inherit from Exlibris::Primo::WebService::Request::Base
        # 
        def method_missing(method, *args, &block)
          if(respond_to_missing? method)
            self.class.send(:define_method, method) { |request|
              raise ArgumentError.new(invalid_type_argument method) unless request.is_a? Exlibris::Primo::WebService::Request::Base
              # Get the Response class that matches the Request class.
              response_klass = "Exlibris::Primo::WebService::Response::#{request.class.name.demodulize}".constantize
              @response = response_klass.new(client.request(method) { soap.body = request.to_xml })
            }
            send method, *args, &block
          else
            super method, *args, &block
          end
        end

        #
        # Tell users that we respond to SOAP actions.
        #
        def respond_to_missing?(method, include_private=false)
          raise NotImplementedError.new(please_subclass) if self.class.abstract?
          (client.wsdl.soap_action method) ? true : super
        end

        def invalid_type_argument method
          "This is an invalid argument. "+
          "The argument to #{method} must be inherit from Exlibris::Primo::WebService::Request::Base"
        end
      end
    end
  end
end