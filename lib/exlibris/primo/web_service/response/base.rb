module Exlibris
  module Primo
    module WebService
      module Response
        class Base
          # Leverage ActiveSupport core extensions
          require 'active_support/core_ext'
          extend Abstract
          include Core
          self.abstract = true
        end
      end
    end
  end
end