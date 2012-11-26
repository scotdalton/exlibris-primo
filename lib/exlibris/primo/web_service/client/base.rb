module Exlibris
  module Primo
    module WebService
      module Client
        class Base
          extend SavonConfig
          include Abstract
          include Config::Attributes
          include SavonClient
          include MagicActions
          include MissingResponse
          include Wsdl

          self.abstract = true

          # Returns a new Exlibris::Primo::WebService::Base from the given arguments,
          # base_url and service.
          #   base_url: base URL for Primo Web Service
          def initialize *args
            super
            @base_url = args.last.delete(:base_url)
            # Set WSDL
            self.wsdl= base_url
            # Set client
            self.client= wsdl
          end
        end
      end
    end
  end
end