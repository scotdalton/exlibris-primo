module WebService
  module Request
    require 'test_helper'
    class FullViewTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
      end

      def test_client
        assert_kind_of Exlibris::Primo::WebService::Client::Search, 
          Exlibris::Primo::WebService::Request::FullView.new(:base_url => @base_url).send(:client)
      end

      def test_full_view
        request = Exlibris::Primo::WebService::Request::FullView.new :base_url => @base_url,
          :institution => @institution, :doc_id => @doc_id
        assert_request request, "fullViewRequest",
          "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
          "<QueryTerms><BoolOpeator>AND</BoolOpeator></QueryTerms>"+
          "<StartIndex>1</StartIndex>"+
          "<BulkSize>5</BulkSize>"+
          "<DidUMeanEnabled>false</DidUMeanEnabled>"+
          "</PrimoSearchRequest>", "<institution>NYU</institution>",
          "<docId>nyu_aleph000062856</docId>"
        VCR.use_cassette('request full view call') do
          assert_nothing_raised {
            request.call
          }
        end
      end
    end
  end
end