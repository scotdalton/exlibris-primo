module Exlibris
  module Primo
    module WebService
      module Request
        module Core
          attr_reader :root
          protected :root

          def initialize
            raise NotImplementedError.new("Cannot instantiate an abstract Request") if self.class.abstract?
            @root = "#{self.class.name.demodulize}Request".camelize(:lower).to_sym
          end
        end
      end
    end
  end
end