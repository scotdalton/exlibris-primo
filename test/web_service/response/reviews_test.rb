module WebService
  module Response
    require 'test_helper'
    class ReviewsTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @isbn = "0143039008"
        @user_id = "N12162279"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
        @dedupmgr_id = "dedupmrg17343091"
        @basket_id ="210075761"
        @new_folder_name = "new folder"
      end

      def test_get_reviews
        VCR.use_cassette('response get reviews') {
          soap_action = :get_reviews
          request = Exlibris::Primo::WebService::Request::GetReviews.new(:user_id => @user_id, 
            :institution => @institution)
          client = Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url)
          response = Exlibris::Primo::WebService::Response::GetReviews.new(
            client.send(soap_action, request.to_xml), soap_action)
        }
      end
    end
  end
end