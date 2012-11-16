module Exlibris
  module Primo
    module WebService
      module Request
        module Core
          DEFAULT_NAMESPACES = {
            "xmlns" => "http://www.exlibris.com/primo/xsd/wsRequest",
            "xmlns:uic" => "http://www.exlibris.com/primo/xsd/primoview/uicomponents"
          }
          DEFAULT_WRAPPER = :request
          attr_reader :root, :namespaces, :wrapper
          protected :root, :namespaces, :wrapper

          def initialize namespaces=DEFAULT_NAMESPACES, wrapper=DEFAULT_WRAPPER
            raise NotImplementedError.new("Cannot instantiate an abstract Request") if self.class.abstract?
            @root = "#{self.class.name.demodulize}Request".camelize(:lower).to_sym
            @namespaces = namespaces
            @wrapper = wrapper.id2name.camelize(:lower).to_sym
          end
        end
      end
    end
  end
end