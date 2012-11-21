module Exlibris
  module Primo
    module Pnx
      module Holdings
        #
        # Gather Holdings for this record.
        #
        def holdings
          @holdings ||=  xml.root.xpath("display/availlibrary").collect do |availlibrary|
            subfields = parse_subfields availlibrary.inner_text
            # Get original id for dealing w/ dedup merger records
            original_id = (subfields["O"]) ? subfields["O"] : recordid
            # Get some info that may or may not be in the Pnx metadata
            title = display_title if self.class.respond_to? :display_title
            author = display_creator if self.class.respond_to? :display_creator
            type = display_type if self.class.respond_to? :display_type
            # Add a new holding to the record's holdings.
            Exlibris::Primo::Holding.new(
              :vid => vid, :institution => subfields["I"],
              :record_id => recordid, :original_id => original_id, 
              :title => title, :author => author, :type => type, 
              :original_source_id => originalsourceids[original_id], :source_id => sourceids[original_id], 
              :source_record_id => sourcerecordids[original_id], :ils_api_id => ilsapiids[original_id],
              :library_code => subfields["L"], 
              :collection => subfields["1"], :call_number => subfields["2"],
              :subfields => subfields, :availability_code => subfields["S"])
            end
        end
      end
    end
  end
end