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

      def test_set_attributes
        query_term = Exlibris::Primo::WebService::Request::QueryTerm.new()
        query_term.value = @isbn
        query_term.precision = "exact"
        query_term.index = "isbn"
        assert_equal "<QueryTerm><IndexField>isbn</IndexField>"+
          "<PrecisionOperator>exact</PrecisionOperator><Value>0143039008</Value></QueryTerm>", query_term.to_xml
      end

      def test_write_attributes
        query_term = Exlibris::Primo::WebService::Request::QueryTerm.new(:value => @isbn, :precision => "exact", :index => "isbn")
        assert_equal "<QueryTerm><IndexField>isbn</IndexField>"+
          "<PrecisionOperator>exact</PrecisionOperator><Value>0143039008</Value></QueryTerm>", query_term.to_xml
      end
    end
  end
end