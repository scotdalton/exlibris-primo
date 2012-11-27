module Exlibris
  module Primo
    module WebService
      module Response
        module Facets
          def facets
            @facets ||= facet_list.xpath("//search:FACET", response_namespaces).collect do |facet|
              accurate = (facet.parent["ACCURATE_COUNTERS"].eql? "true")
              Exlibris::Primo::Facet.new(:raw_xml => facet.to_xml, :accurate => accurate)
            end
          end

          def facet_list
            @facet_list ||= xml.at_xpath("//search:FACETLIST", response_namespaces)
          end
          private :facet_list
        end
      end
    end
  end
end