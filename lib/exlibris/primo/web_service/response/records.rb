module Exlibris
  module Primo
    module WebService
      module Response
        module Records
          def records
            @records ||= xml.xpath("//pnx:record", response_namespaces).collect { |record|
                Exlibris::Primo::Record.new(:raw_xml => record.to_xml, :namespaces => record.namespaces) }
          end
        end
      end
    end
  end
end
