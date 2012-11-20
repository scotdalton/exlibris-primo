module Exlibris
  module Primo
    module Pnx
      module RelatedLinks
        #
        #
        #
        def related_links
          @related_links ||= []
          if @related_links.empty?
            xml.root.xpath("links/addlink").each do |addlink|
              addlink, url, display = process_addlink addlink
              next if url.nil?
              @related_links << Exlibris::Primo::RelatedLink.new(
                :record_id => record_id, :addlink => addlink, 
                :url => url, :display => display, 
                :notes => "")
            end
          end
          @related_links
        end

        def process_addlink(input)
          addlink, url, display, = nil, nil, nil
          addlink = input.inner_text
          addlink.split(/\$(?=\$)/).each do |s|
            url = s.sub!(/^\$U/, "")  unless s.match(/^\$U/).nil?
            display = s.sub!(/^\$D/, "")  unless s.match(/^\$D/).nil?
          end
          return addlink, url, display
        end
        private :process_addlink
      end
    end
  end
end