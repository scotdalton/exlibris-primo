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
            xml.root.xpath("display/availlibrary").each do |availlibrary|
              p availlibrary
              availlibrary, institution_code, library_code, id_one, id_two, status_code, origin = process_availlibrary availlibrary
              holding_original_source_id = originalsourceids[(origin) ? origin : recordid]
              holding_source_id = sourceids[(origin) ? origin : recordid]
              holding_source_record_id = sourcerecordids[(origin) ? origin : recordid]
              title = display_title if self.respond_to? :display_title
              author = display_creator if self.respond_to? :display_creator
              @holdings << Exlibris::Primo::Holding.new(
                :vid => vid, :config => config,
                :record_id => recordid, :title => title, :author => author, 
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
          availlibrary = input.inner_text
          availlibrary.split(/\$(?=\$)/).each do |s|
            institution_code = s.sub!(/^\$I/, "")
            library_code = s.sub!(/^\$L/, "")
            id_one = s.sub!(/^\$1/, "")
            id_two = s.sub!(/^\$2/, "")
            status_code = "check_holdings"
            origin = s.sub!(/^\$O/, "")
          end
          return availlibrary, institution_code, library_code, id_one, id_two, status_code, origin
        end
        private :process_availlibrary
      end
    end
  end
end