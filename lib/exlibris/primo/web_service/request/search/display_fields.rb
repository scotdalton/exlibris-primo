module Exlibris
  module Primo
    module WebService
      module Request
        module DisplayFields
          # 
          # Returns a lambda that takes a Nokogiri::XML::Builder as an argument
          # and appends display fields XML to it.
          # 
          def display_fields_xml
            lambda { |xml|
              display_fields.each do |display_field|
                xml.DisplayFields display_field
              end
            }
          end
          protected :display_fields_xml

          def display_fields
            @display_fields ||= []
          end

          def add_display_field(display_field)
            display_fields << display_field
          end
        end
      end
    end
  end
end