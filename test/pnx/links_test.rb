module Pnx
  require 'test_helper'
  class LinksTest < Test::Unit::TestCase
    def test_fulltexts
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      assert_not_nil record.fulltexts
      assert((not record.fulltexts.empty?))
    end

    def test_tables_of_contents
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      # assert_not_nil record.tables_of_contents
      # assert((not record.tables_of_contents.empty?))
    end

    def test_related_links
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      # assert_not_nil record.related_links
      # assert((not record.related_links.empty?))
    end
  end
end