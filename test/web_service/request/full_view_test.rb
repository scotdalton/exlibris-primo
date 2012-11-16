module WebService
  module Request
    require 'test_helper'
    class FullViewTest < Test::Unit::TestCase
      def setup
        @doc_id = "nyu_aleph000062856"
      end

      def test_request_record
        full_view_request = Exlibris::Primo::WebService::Request::FullView.new
        full_view_request.doc_id = @doc_id
        assert_equal "<request><![CDATA[<fullViewRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" "+
          "xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\">"+
          "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
          "<QueryTerms><BoolOpeator>AND</BoolOpeator></QueryTerms>"+
          "<StartIndex>1</StartIndex><BulkSize>5</BulkSize>"+
          "<DidUMeanEnabled>false</DidUMeanEnabled>"+
          "<HighlightingEnabled>false</HighlightingEnabled>"+
          "<InstBoost>true</InstBoost>"+
          "</PrimoSearchRequest>"+
          "<docId>nyu_aleph000062856</docId>"+
          "</fullViewRequest>]]></request>", full_view_request.to_xml
      end
    end
  end
end