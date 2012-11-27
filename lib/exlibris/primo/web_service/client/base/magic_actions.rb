module Exlibris
  module Primo
    module WebService
      module Client
        module MagicActions
          def self.included(klass)
            klass.class_eval do
              extend Config
            end
          end

          module Config
            def add_magic_actions *actions
              actions.each do |action|
                magic_actions << action unless magic_actions.include? action
              end
            end

            def magic_actions
              @magic_actions ||= []
            end
          end

          def magic_actions
            @magic_actions ||= self.class.magic_actions.concat(client.wsdl.soap_actions)
          end
          
          # 
          # Define methods for SOAP actions. SOAP actions take a single String argument, request_xml,
          # which is set as the body of the SOAP request
          # 
          def method_missing(method, *args, &block)
            if(magic_actions.include? method)
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
            (magic_actions.include? method) ? true : super
          end
        end
      end
    end
  end
end