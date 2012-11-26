module Exlibris
  module Primo
    #
    #
    #
    class Searcher
      include Config::Attributes
      include WriteAttributes
      attr_reader :record_id, :isbn, :title, :author

      def search
        return if insufficient_query?
        @search ||= request.call
      end

      def records
        @records ||= search.records
      end

      def facets
        @facets ||= search.facets
      end

      def count
        @count ||= search.count
      end

      def add_query_term *args
        search_request.add_query_terms *args
      end

      def record_id= record_id
        @record_id = record_id
        full_view_request.doc_id = record_id
      end

      def isbn= isbn
        @isbn = isbn
        add_query_term author, "isbn", "exact"
      end

      def title= title
        @title = title
        add_query_term author, "title", "exact"
      end

      def author= author
        @author = author
        add_query_term author, "creator", "exact"
      end

      # Determine whether we have sufficient search criteria to search
      # Sufficient means either:
      #     * We have a Primo doc id
      #     * We have either an isbn OR an issn
      #     * We have a title AND an author AND a genre
      def insufficient_query?
        return false unless (@primo_id.nil? or @primo_id.empty?)
        return false unless (@issn.nil? or @issn.empty?) and (@isbn.nil? or @isbn.empty?)
        return false unless (@title.nil? or @title.empty?) or (@author.nil? or @author.empty?) or (@genre.nil? or @genre.empty?)
        return true
      end
      private :insufficient_query?

      def full_view_request
        @full_view_request ||= Exlibris::Primo::WebService::Request::FullView.new request_attributes
      end
      private :full_view_request

      def search_request
        @full_view_request ||= Exlibris::Primo::WebService::Request::SearchView.new request_attributes
      end
      private :search_request

      def request_attributes
        @request_attributes || {:base_url =>base_url, :institution => institution, :vid => vid}
      end
      private :request_attributes

      def request
        (record_id) ? full_view_request : search_request
      end
      private :request
    end
  end
end