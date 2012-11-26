module WebService
  module Request
    require 'test_helper'
    class QueryTermTest < Test::Unit::TestCase
      def setup
        @isbn = "0143039008"
        @issn = "0090-5720"
        @title = "Travels with My Aunt"
        @author = "Graham Greene"
        @genre = "Book"
      end

      def test_class
        assert_kind_of Exlibris::Primo::WebService::Request::QueryTerm, Exlibris::Primo::WebService::Request::QueryTerm.new()
      end

      def test_isbn
        query_term = Exlibris::Primo::WebService::Request::QueryTerm.new()
        query_term.value = @isbn
        query_term.precision = "exact"
        query_term.index = "isbn"
        assert_equal "<QueryTerm><IndexField>isbn</IndexField>"+
          "<PrecisionOperator>exact</PrecisionOperator><Value>0143039008</Value></QueryTerm>", query_term.to_xml
      end
    end
  end
end