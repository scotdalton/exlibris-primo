module Exlibris
  module Primo
    module WebService
      module Client
        module Endpoint
          def self.included(klass)
            klass.class_eval do
              extend Config
            end
          end

          module Config
            def endpoint
              @endpoint ||= name.demodulize.downcase
            end
            attr_writer :endpoint
            protected :endpoint=
          end

          def endpoint
            @endpoint ||= "#{base_url}/PrimoWebServices/services/#{self.class.endpoint}"
          end
          protected :endpoint
        end
      end
    end
  end
end