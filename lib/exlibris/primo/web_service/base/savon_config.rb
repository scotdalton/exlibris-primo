module Exlibris
  module Primo
    module WebService
      module SavonConfig
        Savon.configure do |config|

          # By default, Savon logs each SOAP request and response to $stdout.
          # Here's how you can disable logging:
          config.log = false

          # The default log level used by Savon is :debug.
          config.log_level = :warn
        end
      end
    end
  end
end