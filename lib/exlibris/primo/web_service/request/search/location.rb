module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # 
        # 
        class Location
          include WriteAttributes
          include XmlUtil
          attr_accessor :kind, :value
          
          def to_xml
            build_xml do |xml|
              xml.Location(:type => kind, :value => value )
            end
          end
        end
      end
    end
  end
end