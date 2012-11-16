module Exlibris
  module Primo
    module WebService
      module Request
        module ToXml
          def to_xml &block
            build_xml { |xml|
              xml.send(wrapper) {
                xml.cdata build_xml { |xml|
                  xml.send(root, namespaces) {
                    yield xml if block
                    xml << base_elements
                  }
                }
              }
            }
          end
        end
      end
    end
  end
end