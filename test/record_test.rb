require 'test_helper'
class RecordTest < Test::Unit::TestCase
  def test_new_record
    assert_nothing_raised {
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      assert_equal "nyu_aleph000062856", record.recordid
      assert((not record.holdings.empty?))
      assert_equal(1, record.holdings.size)
    }
  end
end