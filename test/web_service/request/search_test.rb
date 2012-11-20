module WebService
  module Request
    require 'test_helper'
    class SearchTest < Test::Unit::TestCase
      def setup
        @base = "http://bobcatdev.library.nyu.edu"
        @institution = "NYU"
        @isbn = "0143039008"
        @issn = "0090-5720"
        @title = "Travels with My Aunt"
        @author = "Graham Greene"
        @genre = "Book"
      end

      def test_client
        assert_equal :search, Exlibris::Primo::WebService::Request::Search.send(:client)
      end

      def test_request_search_issn
          search_request = Exlibris::Primo::WebService::Request::Search.new @base
          search_request.institution = @institution
          search_request.issn = @issn
          assert_request search_request, "searchRequest",
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>isbn</IndexField>"+
            "<PrecisionOperator>exact</PrecisionOperator>"+
            "<Value>0090-5720</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest>", "<institution>NYU</institution>"
          VCR.use_cassette('search request issn call') do
            search_request.call
          end
      end

      def test_request_search_isbn
          search_request = Exlibris::Primo::WebService::Request::Search.new @base
          search_request.institution = @institution
          search_request.isbn = @isbn
          assert_request search_request, "searchRequest",
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>isbn</IndexField>"+
            "<PrecisionOperator>exact</PrecisionOperator>"+
            "<Value>0143039008</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest>", "<institution>NYU</institution>"
          VCR.use_cassette('search request isbn call') do
            search_request.call
          end
      end

      def test_request_search_title
          search_request = Exlibris::Primo::WebService::Request::Search.new @base
          search_request.institution = @institution
          search_request.title = @title
          assert_request search_request, "searchRequest",
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>title</IndexField>"+
            "<PrecisionOperator>contains</PrecisionOperator>"+
            "<Value>Travels with My Aunt</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest>", "<institution>NYU</institution>"
          VCR.use_cassette('search request title call') do
            search_request.call
          end
      end

      def test_request_search_author
          search_request = Exlibris::Primo::WebService::Request::Search.new @base
          search_request.institution = @institution
          search_request.author = @author
          assert_request search_request, "searchRequest",
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>creator</IndexField>"+
            "<PrecisionOperator>contains</PrecisionOperator>"+
            "<Value>Graham Greene</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest>", "<institution>NYU</institution>"
          VCR.use_cassette('search request author call') do
            search_request.call
          end
      end

      def test_request_search_genre
          search_request = Exlibris::Primo::WebService::Request::Search.new @base
          search_request.institution = @institution
          search_request.genre = @genre
          assert_request search_request, "searchRequest",
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>any</IndexField>"+
            "<PrecisionOperator>exact</PrecisionOperator>"+
            "<Value>Book</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>false</DidUMeanEnabled>"+
            "</PrimoSearchRequest>", "<institution>NYU</institution>"
          VCR.use_cassette('search request genre call') do
            # search_request.call
          end
      end

      def test_request_search_title_author_genre
        search_request = Exlibris::Primo::WebService::Request::Search.new @base
        search_request.institution = @institution
        search_request.title = @title
        search_request.author = @author
        search_request.genre = @genre
        assert_request search_request, "searchRequest",
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
          "</PrimoSearchRequest>", "<institution>NYU</institution>"
        VCR.use_cassette('search request title author genre call') do
          search_request.call.records
        end
      end
    end
  end
end