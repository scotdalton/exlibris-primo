module Exlibris
  module Primo
    module WebService
      module Util
        require 'nokogiri'
        # Leverage ActiveSupport core extensions
        require 'active_support/core_ext'

        # Returns an XML string and takes any args that are
        # understood by Nokogiri::XML::Builder.
        def build_xml options={}, &block
          Nokogiri::XML::Builder.new(options.merge(:encoding => 'UTF-8'), &block).to_xml(xml_options).strip
        end
        protected :build_xml

        def namespace ns
          return Nokogiri::XML::Namespace.new
        end

        def xml_options
          @xml_options ||= {
            :indent => 0,
            :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION
          }
        end
        private :xml_options
      end
    end
  end
end