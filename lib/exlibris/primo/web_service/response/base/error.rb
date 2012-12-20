module Exlibris
  module Primo
    module WebService
      module Response
        module Error
          def error?
            (error_code && (not error_code.eql? "0"))
          end

          def error
            @error ||= xml_without_namespaces.root.at_xpath("//ERROR")
          end

          def error_code
            @error_code ||= error["CODE"] if error
          end

          def error_message
            @error_message ||= error["MESSAGE"] if error
          end
        end
      end
    end
  end
end