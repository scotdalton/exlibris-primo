module WebService
  module Client
    require 'test_helper'
    class SearchBenchmarks < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
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
          results.report("Web Service Search:") {
            (1..10).each {
              search = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
              response = search.search_brief "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\"><QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm><IndexField>isbn</IndexField><PrecisionOperator>exact</PrecisionOperator><Value>0090-5720</Value></QueryTerm></QueryTerms><StartIndex>1</StartIndex><BulkSize>5</BulkSize><DidUMeanEnabled>false</DidUMeanEnabled></PrimoSearchRequest><institution>NYU</institution></searchRequest>]]></request>"
            }
          }
        end
        VCR.turn_on!
      end
    end
  end
end