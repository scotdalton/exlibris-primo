module Exlibris
  module Primo
    module Abstract
      def self.included(klass)
        klass.class_eval do
          extend ClassAttributes
        end
      end

      module ClassAttributes
        def abstract
          @abstract ||= false
        end
        alias :abstract? :abstract

        attr_writer :abstract
        protected :abstract=
      end

      def initialize *args
        raise NotImplementedError.new("Cannot instantiate #{self.class.name}.  It is abstract") if self.class.abstract?
      end
    end
  end
end