module WebService
  module Request
    require 'test_helper'
    class EshelfTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "NYU"
        @user_id = "N12162279"
        @doc_id = "nyu_aleph000062856"
      end

      def test_get_eshelf
        request = Exlibris::Primo::WebService::Request::GetEshelf.new :base_url => @base_url,
          :institution => @institution, :user_id => @user_id
        assert_request request, "getEshelfRequest",
          "<institution>NYU</institution>",
          "<userId>N12162279</userId>"
        VCR.use_cassette('request get eshelf') do
          assert_nothing_raised {
            request.call
          }
        end
      end
    end
  end
end