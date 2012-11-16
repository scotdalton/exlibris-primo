module Exlibris
  module Primo
    module WebService
      module Request
        module Util
          require 'nokogiri'

          # Returns an XML string and takes any args that are
          # understood by Nokogiri::XML::Builder.
          def build_xml options={}, &block
            Nokogiri::XML::Builder.new(options.merge(:encoding => 'UTF-8'), &block).to_xml(xml_options).strip
          end
          protected :build_xml

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
end