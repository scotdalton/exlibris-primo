module Exlibris
  module Primo
    # == Overview
    # Class for handling Primo Rsrcs from links/linktorsrc
    class Rsrc
      include SetAttributes
      def self.attributes
        @attributes ||= [
          :recordid,
          :linktorsrc,
          :v,
          :url,
          :display,
          :institution_code,
          :origin,
          :notes ]
      end
      attr_accessor *self.attributes
      def initialize(attributes={})
        set_attributes attributes
      end
    end
  end
end