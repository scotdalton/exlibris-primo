module Exlibris
  module Primo
    # == Overview
    # Class for handling Primo Related Links from links/addlink
    class RelatedLink
      include SetAttributes
      def self.attributes
        @attributes ||= [
          :recordid,
          :addlink, 
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