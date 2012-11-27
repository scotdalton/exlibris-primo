module Exlibris
  module Primo
    #
    #
    #
    class Record
      include Config::Attributes
      include Namespaces
      include WriteAttributes
      include XmlUtil
      include Exlibris::Primo::Pnx::DedupMgr
      include Exlibris::Primo::Pnx::Elements
      include Exlibris::Primo::Pnx::Frbr
      include Exlibris::Primo::Pnx::Holdings
      include Exlibris::Primo::Pnx::Links
      include Exlibris::Primo::Pnx::Openurl
      include Exlibris::Primo::Pnx::Subfields

      def initialize *args
        @raw_xml = args.last.delete(:raw_xml)
        super
      end
    end
  end
end