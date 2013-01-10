module WebService
  module Response
    require 'test_helper'
    class TagsTest < Test::Unit::TestCase
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

      def test_get_tags
        VCR.use_cassette('response get tags') {
          soap_action = :get_tags
          request = Exlibris::Primo::WebService::Request::GetTags.new(:user_id => @user_id, 
            :institution => @institution)
          client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
          response = Exlibris::Primo::WebService::Response::GetTags.new(
            client.send(soap_action, request.to_xml), soap_action)
        }
      end
    end
  end
end