module WebService
  require 'test_helper'
  class SearcherTest < Test::Unit::TestCase
    def setup
      @base = "http://bobcatdev.library.nyu.edu"
      @doc_id = "nyu_aleph000062856"
      @isbn = "0143039008"
      @issn = "0090-5720"
      @title = "Travels with My Aunt"
      @author = "Graham Greene"
      @genre = "Book"
    end

    def test_searcher_by_issn
      VCR.use_cassette('web service searcher search request issn') do
        search_request = Exlibris::Primo::WebService::Request::Search.new
        search_request.institution = "NYU"
        search_request.issn = @issn
        searcher = Exlibris::Primo::WebService::Searcher.new @base
        response = searcher.search_brief search_request
      end
    end

    def test_searcher_by_isbn
      VCR.use_cassette('web service searcher search request isbn') do
        search_request = Exlibris::Primo::WebService::Request::Search.new
        search_request.institution = "NYU"
        search_request.isbn = @isbn
        searcher = Exlibris::Primo::WebService::Searcher.new @base
        response = searcher.search_brief search_request
      end
    end

    def test_searcher_by_doc_id
      VCR.use_cassette('web service searcher record request') do
        record_request = Exlibris::Primo::WebService::Request::FullView.new
        record_request.doc_id = @doc_id
        record_request.institution = "NYU"
        searcher = Exlibris::Primo::WebService::Searcher.new @base
        response = searcher.get_record record_request
      end
    end
  end
end