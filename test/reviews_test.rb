require 'test_helper'
class ReviewsTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @user_id = "N12162279"
    @institution = "NYU"
    @record_id = "nyu_aleph000062856"
  end

  def test_reviews
    VCR.use_cassette('reviews') do
      reviews = Exlibris::Primo::Reviews.new(:base_url => @base_url, :institution => @institution, :user_id => @user_id, :record_id => @record_id)
      assert_not_nil reviews.reviews
      assert((not reviews.reviews.empty?))
    end
  end
end