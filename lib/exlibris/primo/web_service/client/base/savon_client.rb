module Exlibris
  module Primo
    module WebService
      module Client
        module SavonClient
          require 'savon'

          def client
            # 
            # We're not using WSDL at the moment, since
            # we don't want to make an extra HTTP call.
            # 
            # @client ||= Savon.client(wsdl)
            @client ||= Savon.client do
              wsdl.endpoint = endpoint
              wsdl.namespace = endpoint
            end
          end
          protected :client
        end
      end
    end
  end
end