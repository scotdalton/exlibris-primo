module Exlibris
  module Primo
    module Pnx
      # 
      # Handle PNX subfields
      # 
      module Subfields
        #
        # Return a Hash of subfields as keys with their corresponding values
        #
        def parse_subfields s
          Hash[s.scan(/\${2}([^\$])([^\$]+)/)]
        end
        protected :parse_subfields
      end
    end
  end
end