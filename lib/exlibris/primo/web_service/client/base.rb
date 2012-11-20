module Exlibris
  module Primo
    module WebService
      module Client
        class Base
          extend SavonConfig
          include Abstract
          include SavonClient
          include MagicActions
          include Wsdl

          self.abstract = true

          # Returns a new Exlibris::Primo::WebService::Base from the given arguments,
          # base and service.
          #   base: base URL for Primo Web Service
          def initialize base
            super
            # Set WSDL
            self.wsdl= base
            # Set client
            self.client= wsdl
          end
        end
      end
    end
  end
end