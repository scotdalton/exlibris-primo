module Exlibris
  module Primo
    #
    #
    #
    class Search
      include Config::Attributes
      include RequestAttributes
      include WriteAttributes
      attr_reader :record_id, :isbn, :title, :author

      # 
      # Returns the Response from the search.
      # Not really intended for public consumption.
      # 
      def search
        @search ||= request.call
      end

      # 
      # Returns the array of Records from the search.
      # 
      def records
        @records ||= search.records
      end

      # 
      # Returns the array of Facets from the search.
      # 
      def facets
        @facets ||= search.facets
      end

      # 
      # Returns the total number of records from the search
      # 
      def size
        @size ||= search.size
      end

      # 
      # Returns "Did U Mean" suggestion for the search.
      # 
      def did_u_mean
        @did_u_mean ||= search.did_u_mean
      end

      # 
      # Enable "Did U Mean" functionality for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.enable_did_u_mean.add_query_term("Digital dvide", "any", "contains").
      #       search.did_u_mean => "digital d vide"
      # 
      def enable_did_u_mean
        request_attributes[:did_u_mean_enabled] = "true"
        self
      end

      # 
      # Disable "Did U Mean" functionality for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.disable_did_u_mean.add_query_term("Digital dvide", "any", "contains").
      #       search.did_u_mean => nil
      # 
      def disable_did_u_mean
        request_attributes[:did_u_mean_enabled] = "false"
        self
      end

      # 
      # Set page size for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.page_size=(10).
      #       add_query_term("Digital divide", "any", "contains").
      #         search.records.size => 10
      # 
      def page_size= page_size
        request_attributes[:bulk_size] = "#{page_size}"
        self
      end

      # 
      # Set the boolean operator for the search
      # to "AND".
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_query_term("Travels", "title", "contains").
      #       and.add_query_term("Greene", "creator", "contains").search
      # 
      def and
        search_request.boolean_operator = "AND"
        self
      end

      # 
      # Set the boolean operator for the search
      # to "OR".
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_query_term("Travels", "title", "contains").
      #       or.add_query_term("Greene", "creator", "contains").search
      # 
      def or
        search_request.boolean_operator = "OR"
        self
      end

      # 
      # Adds a query term to the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_query_term("Travels", "title", "contains").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_query_term *args
        search_request.add_query_term *args
        self
      end

      # 
      # Sets the record id to search for.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.record_id=("aleph0123456789").search
      # 
      def record_id= record_id
        @record_id = record_id
        full_view_request.doc_id = record_id
        self
      end

      # 
      # Equivalent to Search.new.add_query_term(title, "title", "exact")
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.isbn=("0143039008").search
      # 
      def isbn= isbn
        @isbn = isbn
        add_query_term isbn, "isbn", "exact"
      end

      # 
      # Equivalent to Search.new.add_query_term(title, "title", "exact")
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.author=("Graham Greene").title=("Travels with My Aunt").search
      # 
      def title= title
        @title = title
        add_query_term title, "title", "exact"
      end

      # 
      # Equivalent to add_query_term(author, "creator", "exact")
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.author=("Graham Greene").title=("Travels with My Aunt").search
      # 
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
        return false unless (record_id.nil? or record_id.empty?)
        return false unless (isbn.nil? or isbn.empty?)
        return false unless (title.nil? or title.empty?) or (author.nil? or author.empty?) or (genre.nil? or genre.empty?)
        return true
      end
      private :insufficient_query?

      def full_view_request
        @full_view_request ||= Exlibris::Primo::WebService::Request::FullView.new request_attributes
      end
      private :full_view_request

      def search_request
        @full_view_request ||= Exlibris::Primo::WebService::Request::Search.new request_attributes
      end
      private :search_request

      def request
        (record_id) ? full_view_request : search_request
      end
      private :request
    end
  end
end