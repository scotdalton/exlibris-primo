module Exlibris
  module Primo
    module WebService
      module Wsdl
        # require 'wasabi'
        # def self.included(klass)
        #   klass.class_eval do
        #     # Set an attribute reader on the class
        #     class << self; attr_reader :wsdl end
        #   end
        # end
        attr_reader :wsdl
        protected :wsdl
        
        # Set the WSDL based on the given arguments, base and service.
        #   base: base URL for Primo Web Service
        #   service: desired Primo Web Service
        def wsdl= args
          # unless self.class.instance_variable_defined? :@wsdl
          #   # wsdl = Wasabi.document("#{args[0]}/PrimoWebServices/services/#{args[1]}?wsdl")
          #   wsdl = "#{args[0]}/PrimoWebServices/services/#{args[1]}?wsdl"
          #   self.class.instance_variable_set(:@wsdl, wsdl) 
          # end
          @wsdl ||= "#{args[0]}/PrimoWebServices/services/#{args[1]}?wsdl"
        end
        protected :wsdl=
      end
    end
  end
end