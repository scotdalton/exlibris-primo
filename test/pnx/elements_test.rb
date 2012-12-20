module Pnx
  require 'test_helper'
  class ElementsTest < Test::Unit::TestCase
    def test_elements
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      assert record.respond_to? :display_title
      assert record.respond_to? :recordid
      assert record.respond_to? :all_search_isbn
      assert_equal "Travels with my aunt", record.display_title
      assert_equal "nyu_aleph000062856", record.recordid
      assert_kind_of Array, record.all_search_isbn
      assert_equal ["0143039008", "9780143039006", "9780143\"0390069"], 
        record.all_search_isbn
    end
  end
end