module WebService
  module Client
    require 'test_helper'
    class SearchTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @doc_id = "nyu_aleph000062856"
        @isbn = "0143039008"
        @issn = "0090-5720"
        @title = "Travels with My Aunt"
        @author = "Graham Greene"
        @genre = "Book"
        @institution = "NYU"
      end

      def test_search_brief_by_issn
        assert_nothing_raised {
          VCR.use_cassette('client search brief issn') do
            client = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
            response = client.search_brief "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\"><QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm><IndexField>isbn</IndexField><PrecisionOperator>exact</PrecisionOperator><Value>0090-5720</Value></QueryTerm></QueryTerms><StartIndex>1</StartIndex><BulkSize>5</BulkSize><DidUMeanEnabled>false</DidUMeanEnabled></PrimoSearchRequest><institution>NYU</institution></searchRequest>]]></request>"
          end
        }
      end

      def test_search_brief_by_isnn
        assert_nothing_raised {
          VCR.use_cassette('client search brief isbn') do
            client = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
            response = client.search_brief "<request><![CDATA[<searchRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\"><QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm><IndexField>isbn</IndexField><PrecisionOperator>exact</PrecisionOperator><Value>0143039008</Value></QueryTerm></QueryTerms><StartIndex>1</StartIndex><BulkSize>5</BulkSize><DidUMeanEnabled>false</DidUMeanEnabled></PrimoSearchRequest><institution>NYU</institution></searchRequest>]]></request>"
          end
        }
      end

      def test_get_record
        assert_nothing_raised {
          VCR.use_cassette('client get record') do
            client = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
            response = client.get_record "<request><![CDATA[<fullViewRequest xmlns=\"http://www.exlibris.com/primo/xsd/wsRequest\" xmlns:uic=\"http://www.exlibris.com/primo/xsd/primoview/uicomponents\"><PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\"><QueryTerms><BoolOpeator>AND</BoolOpeator></QueryTerms><StartIndex>1</StartIndex><BulkSize>5</BulkSize><DidUMeanEnabled>false</DidUMeanEnabled></PrimoSearchRequest><institution>NYU</institution><docId>nyu_aleph000062856</docId></fullViewRequest>]]></request>"
          end
        }
      end
    end
  end
end