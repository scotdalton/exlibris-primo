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
        protected :parse_subfields
      end
    end
  end
end