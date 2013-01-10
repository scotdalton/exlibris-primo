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
    VCR.use_cassette('reviews check empty reviews first') do
      assert_not_nil reviews.reviews
      assert(reviews.reviews.empty?)
    end
    VCR.use_cassette('reviews add review') do
      reviews.add_review("Test review", "1", "Scot Thomas")
    end
    VCR.use_cassette('reviews reviews') do
      assert_not_nil reviews.reviews
      assert((not reviews.reviews.empty?))
      assert_equal(1, reviews.reviews.size)
      
    end
    VCR.use_cassette('reviews user') do
      assert_not_nil reviews.user_reviews
      assert((not reviews.user_reviews.empty?))
      assert_equal(2, reviews.user_reviews.size)
    end
    VCR.use_cassette('reviews record') do
      assert_not_nil reviews.record_reviews
      assert((not reviews.record_reviews.empty?))
      assert_equal(1, reviews.record_reviews.size)
    end
    VCR.use_cassette('reviews rating') do
      assert_not_nil reviews.rating_reviews("1")
      assert((not reviews.rating_reviews("1").empty?))
      assert_equal(2, reviews.rating_reviews("1").size)
    end
    VCR.use_cassette('reviews remove review') do
      reviews.remove_review
    end
    VCR.use_cassette('reviews check empty reviews last') do
      assert_not_nil reviews.reviews
      assert(reviews.reviews.empty?)
    end
  end
end