module Exlibris
  module Primo
    module Pnx
      module Holdings
        #
        #
        #
        def holdings
          @holdings ||= []
          if @holdings.empty?
            xml.xpath("display/availlibrary").each do |availlibrary|
              availlibrary, institution_code, library_code, id_one, id_two, status_code, origin = process_availlibrary availlibrary
              holding_original_source_id = (origin.nil?) ? original_source_ids[record_id] : original_source_ids[origin] unless original_source_ids.empty?
              holding_source_id = (origin.nil?) ? source_ids[record_id] : source_ids[origin] unless source_ids.empty?
              holding_source_record_id = (origin.nil?) ? source_record_ids[record_id] : source_record_ids[origin] unless source_record_ids.empty?
              holding_source_record_id =  source_record_id if holding_source_record_id.nil?
              @holdings << Exlibris::Primo::Holding.new(
                :vid => vid, :config => config,
                :record_id => recordid, :title => display_title, :author => display_creator, 
                :original_source_id => holding_original_source_id, :source_id => holding_source_id, 
                :source_record_id => holding_source_record_id, :origin => origin, 
                :availlibrary => availlibrary, :institution_code => institution_code, 
                :library_code => library_code, :id_one => id_one, :id_two => id_two, 
                :status_code => status_code, :origin => origin, :type => display_type, :notes => "")
            end
          end
          @holdings
        end

        def process_availlibrary(input)
          availlibrary, institution_code, library_code, id_one, id_two, status_code, origin =
            nil, nil, nil, nil, nil, nil, nil
          return institution_code, library_code, id_one, id_two, status_code, origin if input.nil? or input.inner_text.nil?
          availlibrary = input.inner_text
          availlibrary.split(/\$(?=\$)/).each do |s|
            institution_code = s.sub!(/^\$I/, "") unless s.match(/^\$I/).nil?
            library_code = s.sub!(/^\$L/, "") unless s.match(/^\$L/).nil?
            id_one = s.sub!(/^\$1/, "") unless s.match(/^\$1/).nil?
            id_two = s.sub!(/^\$2/, "") unless s.match(/^\$2/).nil?
            status_code = "check_holdings"
            origin = s.sub!(/^\$O/, "") unless s.match(/^\$O/).nil?
          end
          return availlibrary, institution_code, library_code, id_one, id_two, status_code, origin
        end
        private :process_availlibrary
      end
    end
  end
end