module WebService
  require 'test_helper'
  class ReviewsTest < Test::Unit::TestCase
    def setup
      @base = "http://bobcatdev.library.nyu.edu"
      @doc_id = "nyu_aleph000062856"
      @user_id = "N12162279"
      @institution = "NYU"
    end

    def test_tags
      VCR.use_cassette('web service get reviews request') do
        reviews_request = Exlibris::Primo::WebService::Request::GetReviews.new
        reviews_request.institution = @institution
        reviews_request.user_id = @user_id
        reviews_request.doc_id = @doc_id
        reviews = Exlibris::Primo::WebService::Reviews.new @base
        response = reviews.get_reviews reviews_request
      end
    end
  end
end