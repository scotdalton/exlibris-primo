module Exlibris
  module Primo
    module WebService
      class Base
        # Leverage ActiveSupport core extensions
        require 'active_support/core_ext'
        extend Abstract
        include SavonConfig
        include Client
        include MagicActions
        include Wsdl

        self.abstract = true

        # Returns a new Exlibris::Primo::WebService::Base from the given arguments,
        # base and service.
        #   base: base URL for Primo Web Service
        #   service: desired Primo Web Service
        def initialize base
          raise NotImplementedError.new("Cannot instantiate an abstract WebService") if self.class.abstract?
          service = self.class.name.demodulize.downcase
          # Set WSDL
          self.wsdl= base, service
          # Set client
          self.client= wsdl
        end
      end
    end
  end
end