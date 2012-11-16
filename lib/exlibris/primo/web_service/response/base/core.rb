module Exlibris
  module Primo
    module WebService
      module Response
        module Core
          attr_reader :response
          def initialize response
            raise NotImplementedError.new("Cannot instantiate an abstract Response") if self.class.abstract?
            @response = response
          end
        end
      end
    end
  end
end