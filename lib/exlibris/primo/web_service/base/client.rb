module Exlibris
  module Primo
    module WebService
      module Client
        require 'savon'
        attr_reader :client
        protected :client

        def client= wsdl
          @client ||= Savon.client(wsdl)
        end
        protected :client=
      end
    end
  end
end