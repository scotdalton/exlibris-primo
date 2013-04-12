module Exlibris
  module Primo
    #
    # Primo record
    # Includes PNX elements such as
    # holdings, links, openurl, frbr status
    # dedupmgr status.
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

      add_duplicated_control_attributes :sourcerecordids, :sourceids,
          :originalsourceids, :sourceformats, :sourcesystems, :ilsapiids

      def initialize *args
        raw_xml = args.last.delete(:raw_xml)
        namespaces = args.last.delete(:namespaces)
        if namespaces.nil?
          @raw_xml = raw_xml
        else
          @raw_xml = remove_namespaces_from_raw_xml(raw_xml, namespaces)
        end
        super
      end
    end
  end
end
