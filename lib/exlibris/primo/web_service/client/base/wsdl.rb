module Exlibris
  module Primo
    module WebService
      module Client
        module Wsdl
          def self.included(klass)
            klass.class_eval do
              extend Config
            end
          end

          module Config
            def wsdl
              @wsdl ||= name.demodulize.downcase
            end
            attr_writer :wsdl
            protected :wsdl=
          end

          attr_reader :wsdl
          protected :wsdl

          def wsdl= base_url
            @wsdl ||= "#{base_url}/PrimoWebServices/services/#{self.class.wsdl}?wsdl"
          end
          protected :wsdl=
        end
      end
    end
  end
end