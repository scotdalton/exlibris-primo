module WebService
  module Client
    require 'test_helper'
    class ReviewsTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @doc_id = "nyu_aleph000062856"
        @user_id = "N12162279"
        @institution = "NYU"
      end

      def test_get_reviews
        assert_nothing_raised {
          VCR.use_cassette('client get reviews') do
            client = Exlibris::Primo::WebService::Client::Reviews.new :base_url => @base_url
            response = client.get_reviews "<request><![CDATA[<getReviewsRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><institution>NYU</institution><docId>nyu_aleph000062856</docId><userId>N12162279</userId></getReviewsRequest>]]></request>"
          end
        }
      end

      def test_get_all_my_reviews
        assert_nothing_raised {
          VCR.use_cassette('client get all my reviews') do
            client = Exlibris::Primo::WebService::Client::Reviews.new :base_url => @base_url
            response = client.get_all_my_reviews "<request><![CDATA[<getAllMyReviewsRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><institution>NYU</institution><userId>N12162279</userId></getAllMyReviewsRequest>]]></request>"
          end
        }
      end
    end
  end
end