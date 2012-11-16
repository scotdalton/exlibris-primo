module WebService
  module Request
    require 'test_helper'
    class SearchTest < Test::Unit::TestCase
      def setup
        @isbn = "0143039008"
        @issn = "0090-5720"
        @title = "Travels with My Aunt"
        @author = "Graham Greene"
        @genre = "Book"
      end
  
      def test_request_search_issn
          search_request = Exlibris::Primo::WebService::Request::Search.new
          search_request.issn = @issn
          assert_equal "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" "+
            "xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\">"+
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>isbn</IndexField>"+
            "<PrecisionOperator>exact</PrecisionOperator>"+
            "<Value>0090-5720</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest></searchRequest>]]></request>", search_request.to_xml
      end

      def test_request_search_isbn
          search_request = Exlibris::Primo::WebService::Request::Search.new
          search_request.isbn = @isbn
          assert_equal "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" "+
            "xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\">"+
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>isbn</IndexField>"+
            "<PrecisionOperator>exact</PrecisionOperator>"+
            "<Value>0143039008</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest></searchRequest>]]></request>", search_request.to_xml
      end

      def test_request_search_title
          search_request = Exlibris::Primo::WebService::Request::Search.new
          search_request.title = @title
          assert_equal "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" "+
            "xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\">"+
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>title</IndexField>"+
            "<PrecisionOperator>contains</PrecisionOperator>"+
            "<Value>Travels with My Aunt</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest></searchRequest>]]></request>", search_request.to_xml
      end

      def test_request_search_author
          search_request = Exlibris::Primo::WebService::Request::Search.new
          search_request.author = @author
          assert_equal "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" "+
            "xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\">"+
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>creator</IndexField>"+
            "<PrecisionOperator>contains</PrecisionOperator>"+
            "<Value>Graham Greene</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest></searchRequest>]]></request>", search_request.to_xml
      end

      def test_request_search_genre
          search_request = Exlibris::Primo::WebService::Request::Search.new
          search_request.genre = @genre
          assert_equal "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" "+
            "xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\">"+
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>any</IndexField>"+
            "<PrecisionOperator>exact</PrecisionOperator>"+
            "<Value>Book</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest></searchRequest>]]></request>", search_request.to_xml
      end

      def test_request_search_title_author_genre
          search_request = Exlibris::Primo::WebService::Request::Search.new
          search_request.title = @title
          search_request.author = @author
          search_request.genre = @genre
          assert_equal "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" "+
            "xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\">"+
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator>"+
            "<QueryTerm>"+
            "<IndexField>title</IndexField>"+
            "<PrecisionOperator>contains</PrecisionOperator>"+
            "<Value>Travels with My Aunt</Value>"+
            "</QueryTerm>"+
            "<QueryTerm>"+
            "<IndexField>creator</IndexField>"+
            "<PrecisionOperator>contains</PrecisionOperator>"+
            "<Value>Graham Greene</Value>"+
            "</QueryTerm>"+
            "<QueryTerm>"+
            "<IndexField>any</IndexField>"+
            "<PrecisionOperator>exact</PrecisionOperator>"+
            "<Value>Book</Value>"+
            "</QueryTerm>"+
            "</QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest></searchRequest>]]></request>", search_request.to_xml
      end
    end
  end
end