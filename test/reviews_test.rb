require 'test_helper'
class ReviewsTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @user_id = "N12162279"
    @institution = "NYU"
    @record_id = "nyu_aleph000062856"
  end

  def test_reviews
    reviews = Exlibris::Primo::Reviews.
      new(:base_url => @base_url, :institution => @institution, 
        :user_id => @user_id, :record_id => @record_id)
    VCR.use_cassette('reviews') do
      assert_not_nil reviews.reviews
      assert((not reviews.reviews.empty?))
    end
    VCR.use_cassette('reviews user') do
      assert_not_nil reviews.user_reviews
      assert((not reviews.user_reviews.empty?))
    end
    VCR.use_cassette('reviews record') do
      assert_not_nil reviews.record_reviews
      assert((not reviews.record_reviews.empty?))
    end
    VCR.use_cassette('reviews rating') do
      assert_not_nil reviews.rating_reviews("1")
      assert((not reviews.rating_reviews("1").empty?))
    end
  end
end