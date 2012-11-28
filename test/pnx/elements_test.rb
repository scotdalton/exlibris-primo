module Pnx
  require 'test_helper'
  class ElementsTest < Test::Unit::TestCase
    def test_elements
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      assert record.respond_to? :display_title
      assert record.respond_to? :recordid
      assert_equal "Travels with my aunt", record.display_title
      assert_equal "nyu_aleph000062856", record.recordid
    end
  end
end