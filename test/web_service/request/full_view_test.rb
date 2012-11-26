module WebService
  module Request
    require 'test_helper'
    class FullViewTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
      end

      def test_class_client
        assert_kind_of Exlibris::Primo::WebService::Client::Search, 
          Exlibris::Primo::WebService::Request::FullView.new(:base_url => @base_url).send(:client)
      end

      def test_request_record
        full_view_request = Exlibris::Primo::WebService::Request::FullView.new :base_url => @base_url
        full_view_request.institution = @institution
        full_view_request.doc_id = @doc_id
        assert_request full_view_request, "fullViewRequest",
          "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
          "<QueryTerms><BoolOpeator>AND</BoolOpeator></QueryTerms>"+
          "<StartIndex>1</StartIndex>"+
          "<BulkSize>5</BulkSize>"+
          "<DidUMeanEnabled>false</DidUMeanEnabled>"+
          "</PrimoSearchRequest>", "<institution>NYU</institution>",
          "<docId>nyu_aleph000062856</docId>"
        VCR.use_cassette('full view request call') do
          full_view_request.call
        end
      end
    end
  end
end