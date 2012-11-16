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

  def test_benchmarks
    VCR.turn_off!
    Benchmark.bmbm do |results|
      results.report("Searcher:") {
        (1..10).each {
          search_request = Exlibris::Primo::WebService::Request::Search.new
          search_request.institution = @institution
          search_request.issn = @issn
          searcher = Exlibris::Primo::WebService::Searcher.new @base
          response = searcher.search_brief search_request
        }
      }
    end
    VCR.turn_on!
  end
end