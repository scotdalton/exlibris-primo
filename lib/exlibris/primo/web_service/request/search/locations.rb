module Exlibris
  module Primo
    module WebService
      module Request
        module Locations
          # 
          # Returns a lambda that takes a Nokogiri::XML::Builder as an argument
          # and appends locations XML to it.
          # 
          def locations_xml
            lambda { |xml|
              # Specify the uic namespace. Not great, but adequate.
              xml.Locations {
                locations.each do |location|
                  xml['uic'].Location(:type => location.kind, :value => location.value)
                end
              } unless locations.empty?
            }
          end
          protected :locations_xml

          def locations
            @locations ||= []
          end

          def add_location(kind, value)
            locations << Location.new(:kind => kind, :value => value)
          end
        end
      end
    end
  end
end