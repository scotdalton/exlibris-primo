module Exlibris
  module Primo
    module WebService
      module Request
        module Locations
          def locations_xml
            build_xml do |xml|
              xml.Locations {
                locations.each do |location|
                  xml << location.to_xml
                end
              }
            end
          end
          protected :locations_xml

          def locations
            @locations ||= []
          end

          def add_location(value, kind)
            locations << Location.new(:value => value, :kind => kind)
          end
        end
      end
    end
  end
end