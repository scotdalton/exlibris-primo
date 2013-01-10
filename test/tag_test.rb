require 'test_helper'
class TagTest < Test::Unit::TestCase
  def test_new_tag
    assert_nothing_raised {
      tag = Exlibris::Primo::Tag.new(:raw_xml => "<Tag><value>spies</value><docId>nyu_aleph000062856</docId><userId/><status/></Tag>")
      assert_equal "", tag.user_id
      assert_equal "nyu_aleph000062856", tag.record_id
      assert_equal "spies", tag.value
      assert_equal "", tag.status
    }
  end
end