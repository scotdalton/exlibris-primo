module Exlibris
  module Primo
    module WriteAttributes

      def initialize *args
        # Just call super w/o any args for now.  Eventually, we'll want to check the arity and adjust.
        # self.class.superclass.instance_method(:initialize).arity.eql? self.class.instance_method(:initialize).arity
        super()
        write_attributes args.last unless args.last.nil?
      end

      def write_attributes attributes
        attributes.each do |attribute, value|
          write_attribute attribute, value
        end
      end

      def attributize symbol
        symbol.id2name.sub(/=$/, "").to_sym
      end
      protected :attributize

      def write_attribute attribute, value
        attribute_writer = writify attribute
        send attribute_writer, value if respond_to? attribute_writer
      end
      private :write_attribute

      def writify key
        "#{key}=".to_sym
      end
      private :writify
    end
  end
end