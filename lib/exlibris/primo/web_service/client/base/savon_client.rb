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
            # @client ||= Savon.client(wsdl: wsdl)
            @client ||= Savon.client(endpoint: endpoint, namespace: endpoint, log: false, log_level: :warn)
          end
          protected :client
        end
      end
    end
  end
end