module Exlibris
  module Primo
    module WebService
      module Response
        module Error
          def error?
            false
          end

          def error_code
            @error_code ||= xml_without_namespaces.root.at_xpath("//ERROR")["CODE"]
          end

          def error_message
            @error_message ||= xml_without_namespaces.root.at_xpath("//ERROR")["MESSAGE"]
          end
        end
      end
    end
  end
end