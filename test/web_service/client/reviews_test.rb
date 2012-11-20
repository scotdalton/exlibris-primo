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
        reviews = Exlibris::Primo::WebService::Client::Reviews.new @base
        response = reviews.get_reviews "<request><![CDATA[<getReviewsRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><institution>NYU</institution><docId>nyu_aleph000062856</docId><userId>N12162279</userId></getReviewsRequest>]]></request>"
      end
    end
  end
end