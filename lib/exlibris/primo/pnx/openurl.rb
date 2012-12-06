module Exlibris
  module Primo
    module Pnx
      # 
      # Handle OpenURL elements
      # 
      module Openurl
        #
        # Parse addata to provide an OpenURL query string
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