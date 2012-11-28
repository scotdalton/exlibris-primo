require 'test_helper'
class RecordTest < Test::Unit::TestCase
  def test_new
    assert_nothing_raised {
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      }
  end
end