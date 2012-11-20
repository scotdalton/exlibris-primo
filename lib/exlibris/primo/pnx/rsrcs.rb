module Exlibris
  module Primo
    module Pnx
      module Rsrcs
        #
        #
        #
        def rsrcs
          @rsrcs ||= []
          if @rsrcs.empty?
            xml.xpath("links/linktorsrc").each do |linktorsrc|
              linktorsrc, v, url, display, institution_code, origin = process_linktorsrc linktorsrc
              next if url.nil?
               @rsrcs << Exlibris::Primo::Rsrc.new(
                :record_id => record_id, :linktorsrc => linktorsrc, 
                :v => v, :url => url, :display => display, 
                :institution_code => institution_code, :origin => origin,
                :notes => "")
            end
          end
          @rsrcs
        end

        def process_linktorsrc(input)
          linktorsrc, v, url, display, institution_code, origin = nil, nil, nil, nil, nil, nil
          return linktorsrc, v, url, display, institution_code, origin if input.nil? or input.inner_text.nil?
          linktorsrc = input.inner_text
          linktorsrc.split(/\$(?=\$)/).each do |s|
            v = s.sub!(/^\$V/, "")
            url = s.sub!(/^\$U/, "")
            display = s.sub!(/^\$D/, "")
            institution_code = s.sub!(/^\$I/, "")
            origin = s.sub!(/^\$O/, "")
          end
          return linktorsrc, v, url, display, institution_code, origin
        end
        private :process_linktorsrc
      end
    end
  end
end