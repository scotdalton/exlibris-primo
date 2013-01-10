require 'test_helper'
class ReviewTest < Test::Unit::TestCase
  def test_new_review
    assert_nothing_raised {
      review = Exlibris::Primo::Review.new(:raw_xml => "<Review><value>Testreview</value><docId>nyu_aleph000062856</docId><userId/><status>2</status><rating>1</rating><userDisplayName/><allowUserName>false</allowUserName></Review>")
      assert_equal "", review.user_id
      assert_equal "nyu_aleph000062856", review.record_id
      assert_equal "Testreview", review.value
      assert_equal "2", review.status
      assert_equal "1", review.rating
      assert_equal "", review.user_display_name
      assert_equal false, review.allow_user_name?
    }
  end
end