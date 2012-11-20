module Exlibris
  module Primo
    # == Overview
    # Class for handling Primo TOCs from links/linktotoc
    class Toc
      include SetAttributes
      def self.attributes
        @attributes ||= [
          :recordid,
          :linktotoc, 
          :url, 
          :display,  
          :notes ]
      end
      attr_accessor *self.attributes
      def initialize(attributes={})
        set_attributes attributes
      end
    end
  end
end