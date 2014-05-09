module Pnx
  require 'test_helper'
  class LinksTest < Test::Unit::TestCase
    def test_fulltexts
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      assert_not_nil record.fulltexts
      assert((not record.fulltexts.empty?))
      assert_not_nil(record.fulltexts.first.institution)
      assert_equal("NYU", record.fulltexts.first.institution)
      assert_not_nil(record.fulltexts.first.record_id)
      assert_equal("dedupmrg17343091", record.fulltexts.first.record_id)
      assert_not_nil(record.fulltexts.first.original_id)
      assert_equal("nyu_aleph000932393", record.fulltexts.first.original_id)
      assert_not_nil(record.fulltexts.first.url)
      assert_not_nil(record.fulltexts.first.display)
    end

    def test_fulltexs_with_title_in_template_field
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      assert_equal("linktosrc_code", record.fulltexts[1].display_code)
    end

    def test_tables_of_contents
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      assert_not_nil record.tables_of_contents
      assert((not record.tables_of_contents.empty?))
      assert_not_nil(record.tables_of_contents.first.institution)
      assert_equal("NYUAD", record.tables_of_contents.first.institution)
      assert_not_nil(record.tables_of_contents.first.record_id)
      assert_equal("dedupmrg17343091", record.tables_of_contents.first.record_id)
      assert_not_nil(record.tables_of_contents.first.original_id)
      assert_equal("nyu_aleph002959842", record.tables_of_contents.first.original_id)
      assert_not_nil(record.tables_of_contents.first.url)
      assert_equal("https://ezproxy.library.nyu.edu/login?url=http://toc.example.com", record.tables_of_contents.first.url)
      assert_not_nil(record.tables_of_contents.first.display)
      assert_equal("Example TOC", record.tables_of_contents.first.display)
    end

    def test_related_links
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      assert_not_nil record.related_links
      assert((not record.related_links.empty?))
      assert_equal("NYUAD", record.related_links.first.institution)
      assert_not_nil(record.related_links.first.record_id)
      assert_not_nil(record.related_links.first.record_id)
      assert_equal("dedupmrg17343091", record.related_links.first.record_id)
      assert_not_nil(record.related_links.first.original_id)
      assert_equal("nyu_aleph002959842", record.related_links.first.original_id)
      assert_not_nil(record.related_links.first.url)
      assert_equal("https://ezproxy.library.nyu.edu/login?url=http://addlink.example.com", record.related_links.first.url)
      assert_not_nil(record.related_links.first.display)
      assert_equal("Example Related Link", record.related_links.first.display)
    end
  end
end
