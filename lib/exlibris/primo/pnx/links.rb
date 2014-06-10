module Exlibris
  module Primo
    module Pnx
      #
      # Handle links in links tags.
      #
      module Links
        #
        # Parse linktorsrc tags to find full text links
        #
        def fulltexts
          @fulltexts ||=
            links("linktorsrc").collect { |link_attributes|
              Exlibris::Primo::Fulltext.new link_attributes }
        end

        #
        # Parse addlink tags to find related links
        #
        def related_links
          @related_links ||= 
            links("addlink").collect { |link_attributes| 
              Exlibris::Primo::RelatedLink.new link_attributes }
        end

        #
        # Parse linktotoc tags to find table of contents links
        #
        def tables_of_contents
          @tables_of_contents ||=
            links("linktotoc").collect { |link_attributes|
              Exlibris::Primo::TableOfContents.new link_attributes }
        end

        #
        # Parse links tags
        #
        def links(link)
          xml.root.xpath("links/#{link}").collect do |link|
            subfields = parse_subfields link.inner_text
            # Get original id for dealing w/ dedup merger records
            original_id = (subfields["O"]) ? subfields["O"] : recordid
            # We're not interested if we don't have a URL
            next if subfields["U"].nil?
            { :institution => subfields["I"],
              :record_id => recordid, :original_id => original_id,
              :url => subfields["U"], :display => subfields["D"], :display_code => subfields['E'] }
          end
        end
        private :links
      end
    end
  end
end
