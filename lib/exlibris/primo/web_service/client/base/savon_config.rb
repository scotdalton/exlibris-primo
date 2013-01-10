module Exlibris
  module Primo
    module WebService
      module Client
        module SavonConfig
          # Turn off HTTPI logging
          HTTPI.log = false
          Savon.configure do |config|
            # By default, Savon logs each SOAP request and response to $stdout.
            # Disable logging.
            config.log = false
            # The default log level used by Savon is :debug.
            config.log_level = :warn
          end
        end
      end
    end
  end
end