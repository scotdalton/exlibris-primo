module Exlibris
  module Primo
    module Pnx
      module Openurl
        #
        #
        #
        def openurl
          @openurl ||= ""
          if @openurl.blank?
            xml.root.xpath("addata/*").each do |addata|
              @openurl << "rft.#{addata.name}=#{addata.inner_text}&" unless (addata.inner_text.nil? or addata.inner_text.strip.empty?)
            end
            @openurl << "rft.primo=#{@record_id}"
          end
          @openurl
        end
      end
    end
  end
end