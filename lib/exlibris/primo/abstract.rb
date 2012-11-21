module Exlibris
  module Primo
    module Abstract
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end

      module Config
        attr_writer :abstract
        def abstract
          @abstract ||= false
        end
        alias :abstract? :abstract
      end

      def initialize *args
        raise NotImplementedError.new("Cannot instantiate #{self.class.name}.  It is abstract") if self.class.abstract?
      end
    end
  end
end