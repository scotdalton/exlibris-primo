module Exlibris
  module Primo
    module WebService
      module Response
        module Error
          def code
            @code ||= xml.root.at_xpath("//ERROR")
          end
        end
      end
    end
  end
end