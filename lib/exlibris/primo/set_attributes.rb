module Exlibris
  module Primo
    module SetAttributes
      def set_attributes attributes
        attributes.each do |key, value|
          key = writify key
          send key, value if respond_to? key
        end
      end
      
      def writify key
        "#{key}=".to_sym
      end
      private :writify
    end
  end
end