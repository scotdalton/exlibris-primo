module WebService
  module Request
    require 'test_helper'
    class TagsTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "NYU"
        @user_id = "N12162279"
        @doc_id = "nyu_aleph000062856"
      end

      def test_get_tags
        request = Exlibris::Primo::WebService::Request::GetTags.new :base_url => @base_url,
          :institution => @institution, :doc_id => @doc_id, :user_id => @user_id
        assert_request request, "getTagsRequest",
          "<institution>NYU</institution>",
          "<docId>nyu_aleph000062856</docId>",
          "<userId>N12162279</userId>"
        VCR.use_cassette('request get tags') do
          assert_nothing_raised {
            response = request.call
          }
        end
      end
    end
  end
end