module Exlibris
  module Primo
    module WebService
      module Response
        class Base
          extend Abstract
          include Core
          self.abstract = true
        end
      end
    end
  end
end