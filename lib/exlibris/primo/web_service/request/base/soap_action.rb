module Exlibris
  module Primo
    module WebService
      module Request
        module SoapAction
          def self.included(klass)
            klass.class_eval do
              extend ClassAttributes
            end
          end

          module ClassAttributes
            def soap_action
              @soap_action ||= name.demodulize.underscore.to_sym
            end

            attr_writer :soap_action
            protected :soap_action=
          end

          def soap_action
            @soap_action ||= self.class.soap_action
          end
          protected :soap_action
        end
      end
    end
  end
end