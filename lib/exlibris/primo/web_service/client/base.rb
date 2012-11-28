module Exlibris
  module Primo
    module WebService
      module Client
        class Base
          extend SavonConfig
          include Abstract
          include Config::Attributes
          include Endpoint
          include SavonClient
          include SoapActions
          include Wsdl

          self.abstract = true

          # Returns a new Exlibris::Primo::WebService::Base from the given arguments,
          # base_url and service.
          #   base_url: base URL for Primo Web Service
          def initialize *args
            super
            @base_url = args.last.delete(:base_url)
          end
        end
      end
    end
  end
end