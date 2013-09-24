module Exlibris
  module Primo
    module WebService
      module Client
        module SoapActions
          def self.included(klass)
            klass.class_eval do
              extend ClassAttributes
            end
          end

          module ClassAttributes
            def soap_actions
              @soap_actions ||= []
            end

            def add_soap_actions *actions
              actions.each do |action|
                soap_actions << action unless soap_actions.include? action
              end
            end
            protected :add_soap_actions
          end

          def soap_actions
            @soap_actions ||= self.class.soap_actions #.concat(client.wsdl.soap_actions)
          end
          protected :soap_actions
          
          # 
          # Define methods for SOAP actions. SOAP actions take a single String argument, request_xml,
          # which is set as the body of the SOAP request
          # 
          def method_missing(method, *args, &block)
            if(soap_actions.include? method)
              self.class.send(:define_method, method) { |request_xml|
                client.call(method, message: request_xml)
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
            (soap_actions.include? method) ? true : super
          end
        end
      end
    end
  end
end