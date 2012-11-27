module Exlibris
  module Primo
    #
    #
    #
    class Record
      include Config::Attributes
      include MissingResponse
      include Namespaces
      include WriteAttributes
      include XmlUtil
      include Exlibris::Primo::Pnx::DedupMgr
      include Exlibris::Primo::Pnx::Elements
      include Exlibris::Primo::Pnx::Holdings
      include Exlibris::Primo::Pnx::Links
      include Exlibris::Primo::Pnx::Openurl
      include Exlibris::Primo::Pnx::Subfields

      def initialize *args
        @raw_xml = args.last.delete(:raw_xml)
        super
      end

      def url
        @url ||= "#{base_url}/primo_library/libweb/action/dlDisplay.do?dym=false&onCampus=false&docId=#{record_id}&institution=#{institution}&vid=#{vid}"
      end
    end
  end
end