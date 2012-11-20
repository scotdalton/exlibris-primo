module Exlibris
  module Primo
    module WebService
      module Response
        module Records
          def records
            @records ||= []
            if @records.empty?
              xml.search("//pnx:record", response_namespaces).each do |record|
                @records << Exlibris::Primo::Record.new(:raw_xml => record.to_xml)
              end
            end
            @records
          end
        end
      end
    end
  end
end