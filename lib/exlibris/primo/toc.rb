module Exlibris
  module Primo
    # Class for handling Primo TOCs from links/linktotoc
    class Toc
      @base_attributes = [ :record_id, :linktotoc, :url, :display,  :notes ]
      class << self; attr_reader :base_attributes end
      def initialize(options={})
        base_attributes = (self.class.base_attributes.nil?) ? 
          Exlibris::Primo::Toc.base_attributes : self.class.base_attributes
        base_attributes.each { |attribute|
          self.class.send(:attr_reader, attribute)
        }
        options.each { |option, value| 
          self.instance_variable_set(('@'+option.to_s).to_sym, value) 
        }
      end
    end
  end
end