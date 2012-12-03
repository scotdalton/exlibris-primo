module WebService
  module Request
    require 'test_helper'
    class SearchTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "NYU"
        @isbn = "0143039008"
        @issn = "0090-5720"
        @title = "Travels with My Aunt"
        @author = "Graham Greene"
        @genre = "Book"
        @doc_id = "nyu_aleph000062856"
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
        VCR.use_cassette('request full view') do
          assert_nothing_raised {
            response = request.call
          }
        end
      end

      def test_request_search_issn
          request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          request.institution = @institution
          request.add_query_term @issn, "isbn", "exact"
          assert_request request, "searchRequest",
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
          VCR.use_cassette('request search issn') do
            assert_nothing_raised {
              response = request.call
            }
          end
      end

      def test_request_search_isbn
          request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          request.institution = @institution
          request.add_query_term @isbn, "isbn", "exact"
          assert_request request, "searchRequest",
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
          VCR.use_cassette('request search isbn') do
            assert_nothing_raised {
              response = request.call
            }
          end
      end

      def test_request_search_title
          request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          request.institution = @institution
          request.add_query_term @title, "title"
          assert_request request, "searchRequest",
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
          VCR.use_cassette('request search title') do
            assert_nothing_raised {
              response = request.call
            }
          end
      end

      def test_request_search_did_u_mean
          request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          request.institution = @institution
          request.did_u_mean_enabled = true
          request.add_query_term "Digital dvide", "title"
          assert_request request, "searchRequest",
            "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
            "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
            "<IndexField>title</IndexField>"+
            "<PrecisionOperator>contains</PrecisionOperator>"+
            "<Value>Digital dvide</Value>"+
            "</QueryTerm></QueryTerms>"+
            "<StartIndex>1</StartIndex>"+
            "<BulkSize>5</BulkSize>"+
            "<DidUMeanEnabled>true</DidUMeanEnabled>"+
            "</PrimoSearchRequest>", "<institution>NYU</institution>"
          VCR.use_cassette('request search did u mean') do
            assert_nothing_raised {
              response = request.call
            }
          end
      end

      def test_request_search_author
          request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          request.institution = @institution
          request.add_query_term @author, "creator"
          assert_request request, "searchRequest",
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
          VCR.use_cassette('request search author') do
            assert_nothing_raised {
              response = request.call
            }
          end
      end

      def test_request_search_genre
          request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          request.institution = @institution
          request.add_query_term @genre, "any", "exact"
          assert_request request, "searchRequest",
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
          VCR.use_cassette('request search genre') do
            assert_nothing_raised {
              response = request.call
            }
          end
      end
      
      def test_search_locations
        request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
        request.institution = @institution
        request.add_query_term @isbn, "isbn", "exact"
        request.add_location "local", "scope:(NYU)"
        assert_request request, "searchRequest",
          "<PrimoSearchRequest xmlns=\"http://www.exlibris.com/primo/xsd/search/request\">"+
          "<QueryTerms><BoolOpeator>AND</BoolOpeator><QueryTerm>"+
          "<IndexField>isbn</IndexField>"+
          "<PrecisionOperator>exact</PrecisionOperator>"+
          "<Value>0143039008</Value>"+
          "</QueryTerm></QueryTerms>"+
          "<StartIndex>1</StartIndex>"+
          "<BulkSize>5</BulkSize>"+
          "<DidUMeanEnabled>false</DidUMeanEnabled>"+
          "<Locations><uic:Location type=\"local\" value=\"scope:(NYU)\"/></Locations>"+
          "</PrimoSearchRequest>", "<institution>NYU</institution>"
        VCR.use_cassette('request search locations') do
          assert_nothing_raised {
            response = request.call
          }
        end
      end

      def test_request_search_title_author_genre
        request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
        request.institution = @institution
        request.add_query_term @title, "title"
        request.add_query_term @author, "creator"
        request.add_query_term @genre, "any", "exact"
        assert_request_children(request, "searchRequest") do |child|
          if child.children.size > 1
            assert_nil child.namespace.prefix
            assert_equal "http://www.exlibris.com/primo/xsd/search/request", child.namespace.href
            child.children.each do |grand_child|
              if grand_child.children.size > 1
                assert_equal 4, grand_child.children.size
                grand_child.children.each do |great_grand_child|
                  assert [
                    "<BoolOpeator>AND</BoolOpeator>",
                    "<QueryTerm><IndexField>title</IndexField>"+
                    "<PrecisionOperator>contains</PrecisionOperator>"+
                    "<Value>Travels with My Aunt</Value></QueryTerm>",
                    "<QueryTerm><IndexField>creator</IndexField>"+
                    "<PrecisionOperator>contains</PrecisionOperator>"+
                    "<Value>Graham Greene</Value></QueryTerm>",
                    "<QueryTerm><IndexField>any</IndexField>"+
                    "<PrecisionOperator>exact</PrecisionOperator>"+
                    "<Value>Book</Value></QueryTerm>"].include? xmlize(great_grand_child)
                end
              else
                assert ["<StartIndex>1</StartIndex>", "<BulkSize>5</BulkSize>", 
                  "<DidUMeanEnabled>false</DidUMeanEnabled>"].include? xmlize(grand_child)
              end
            end
          else
            assert_equal "<institution>NYU</institution>", xmlize(child)
          end
        end
        VCR.use_cassette('request search title author genre') do
          assert_nothing_raised {
            response = request.call
          }
        end
      end
    end
  end
end