module Exlibris
  module Primo
    module WebService
      module Abstract
        attr_writer :abstract
        def abstract
          @abstract ||= false
        end
        alias :abstract? :abstract
      end
    end
  end
end
