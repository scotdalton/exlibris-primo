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
            v = s.sub!(/^\$V/, "")  unless s.match(/^\$V/).nil?
            url = s.sub!(/^\$U/, "")  unless s.match(/^\$U/).nil?
            display = s.sub!(/^\$D/, "")  unless s.match(/^\$D/).nil?
            institution_code = s.sub!(/^\$I/, "") unless s.match(/^\$I/).nil?
            origin = s.sub!(/^\$O/, "") unless s.match(/^\$O/).nil?
          end
          return linktorsrc, v, url, display, institution_code, origin
        end
        private :process_linktorsrc
      end
    end
  end
end