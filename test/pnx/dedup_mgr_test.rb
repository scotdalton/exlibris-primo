module Pnx
  require 'test_helper'
  class DedupMgrTest < Test::Unit::TestCase
    def test_dedupmrg
      record = Exlibris::Primo::Record.new(:raw_xml => dedupmgr_record_xml)
      assert record.respond_to? :display_title
      assert record.respond_to? :recordid
      assert_equal "The New York times", record.display_title
      assert_equal "dedupmrg17343091", record.recordid
      assert((not record.sourceids.keys.include?("dedupmrg17343091")))
      assert_raise(NoMethodError) {
        record.non_existent_method
      }
    end
  end
end