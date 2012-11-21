module Exlibris
  module Primo
    module Pnx
      module Subfields
        #
        #
        #
        def parse_subfields s
          Hash[s.scan(/\${2}([^\$])([^\$]+)/)]
        end
      end
    end
  end
end