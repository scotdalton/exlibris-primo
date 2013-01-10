module WebService
  module Response
    require 'test_helper'
    class ErrorTest < Test::Unit::TestCase
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
        VCR.use_cassette('response add tag') {
          soap_action = :add_tag
          request = Exlibris::Primo::WebService::Request::AddTag.new(:user_id => @user_id, 
            :institution => @institution, :doc_id => @doc_id, :value => "test tag")
          client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
          response =Exlibris::Primo::WebService::Response::AddTag.new(
            client.send(soap_action, request.to_xml), soap_action)
            assert((not response.error?))
            assert_equal("0", response.error_code)
            assert_equal("Add tag action completed successfully", response.error_message)
        }
      end
    end
  end
end