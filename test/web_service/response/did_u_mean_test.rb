module WebService
  module Response
    require 'test_helper'
    class DidUMeanTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @isbn = "0143039008"
        @user_id = "N12162279"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
        @dedupmgr_id = "dedupmrg17343091"
        @basket_id ="210075761"
        @did_u_mean_title = "Digital dvide"
      end

      def test_did_u_mean_enabled
        VCR.use_cassette('response did u mean enabled') {
          soap_action = :search_brief
          request = Exlibris::Primo::WebService::Request::Search.new(:user_id => @user_id, 
            :institution => @institution, :did_u_mean_enabled => "true")
          request.add_query_term(@did_u_mean_title, "title")
          client = Exlibris::Primo::WebService::Client::Search.new(:base_url => @base_url)
          response = Exlibris::Primo::WebService::Response::Search.new(
            client.send(soap_action, request.to_xml), soap_action)
          assert_not_nil response.did_u_mean
          assert_equal "digital d vide", response.did_u_mean
        }
      end

      def test_did_u_mean_disabled
        VCR.use_cassette('response did u mean disabled') {
          soap_action = :search_brief
          request = Exlibris::Primo::WebService::Request::Search.new(:user_id => @user_id, 
            :institution => @institution)
          request.add_query_term(@did_u_mean_title, "title")
          client = Exlibris::Primo::WebService::Client::Search.new(:base_url => @base_url)
          response = Exlibris::Primo::WebService::Response::Search.new(
            client.send(soap_action, request.to_xml), soap_action)
          assert_nil response.did_u_mean
        }
      end
    end
  end
end