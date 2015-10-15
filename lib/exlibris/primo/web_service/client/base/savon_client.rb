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
            @client ||= Savon.client(client_options)
          end
          protected :client
          
          def client_options
            {
              proxy: proxy_url, 
              endpoint: endpoint, 
              namespace: endpoint, 
              log: false, 
              log_level: :warn
            }.delete_if { |k, v| v.blank? }
          end
          private :client_options
        end
      end
    end
  end
end