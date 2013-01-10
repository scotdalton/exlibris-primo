module WebService
  module Request
    require 'test_helper'
    class ReviewsTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "NYU"
        @user_id = "N12162279"
        @doc_id = "nyu_aleph000062856"
      end

      def test_get_reviews
        request = Exlibris::Primo::WebService::Request::GetReviews.new :base_url => @base_url,
          :institution => @institution, :doc_id => @doc_id, :user_id => @user_id
        assert_request request, "getReviewsRequest",
          "<institution>NYU</institution>",
          "<docId>nyu_aleph000062856</docId>",
          "<userId>N12162279</userId>"
        VCR.use_cassette('request get reviews') do
          assert_nothing_raised {
            response = request.call
          }
        end
      end
    end
  end
end