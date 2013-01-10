module WebService
  module Client
    require 'test_helper'
    class TagsTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @doc_id = "nyu_aleph000062856"
        @user_id = "N12162279"
        @institution = "NYU"
      end

      def test_get_tags
        assert_nothing_raised {
          VCR.use_cassette('client get tags') do
            client = Exlibris::Primo::WebService::Client::Tags.new :base_url => @base_url
            response = client.get_tags "<request><![CDATA[<getTagsRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><institution>NYU</institution><docId>nyu_aleph000062856</docId><userId>N12162279</userId></getTagsRequest>]]></request>"
          end
        }
      end

      def test_get_all_my_tags
        assert_nothing_raised {
          VCR.use_cassette('client get all my tags') do
            client = Exlibris::Primo::WebService::Client::Tags.new :base_url => @base_url
            response = client.get_all_my_tags "<request><![CDATA[<getAllMyTagsRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><institution>NYU</institution><userId>N12162279</userId></getAllMyTagsRequest>]]></request>"
          end
        }
      end
    end
  end
end