module Exlibris
  module Primo
    module SearchAttributes
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

      # 
      # Set start index for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.start_index=(11).
      #       add_query_term("Digital divide", "any", "contains").
      #         search.records.first => 11th record from the search
      # 
      def start_index= start_index
        request_attributes[:start_index] = "#{start_index}"
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
      # Enable highlighting functionality for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.enable_highlighting.add_query_term("Digital dvide", "any", "contains").
      #       search.did_u_mean => "digital d vide"
      # 
      def enable_highlighting
        request_attributes[:highlighting_enabled] = "true"
        self
      end

      # 
      # Disable highlighting functionality for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.disable_highlighting.add_query_term("Digital dvide", "any", "contains").
      #       search.did_u_mean => nil
      # 
      def disable_highlighting
        request_attributes[:highlighting_enabled] = "false"
        self
      end

      # 
      # Adds a language to the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_language("eng").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_language *args
        search_request.add_language *args
        self
      end

      # 
      # Adds a sort by to the search.
      # Currently the Primo API only supports
      # one sort by value. Add multiple
      # sort bys at your own peril.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_sort_by("stitle").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_sort_by *args
        search_request.add_sort_by *args
        self
      end

      # 
      # Adds a display field (for highlighting) to the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_display_field("creator").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_display_field *args
        search_request.add_display_field *args
        self
      end

      # 
      # Adds a location to the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_location("local", "scope:(VOLCANO)").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_location *args
        search_request.add_location *args
        self
      end

      # 
      # Adds a local location to the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_local_location("scope:(VOLCANO)").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_local_location location
        add_location "local", location
      end

      # 
      # Adds an adaptor location to the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_adaptor_location("primo_central_multiple_fe").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_adaptor_location location
        add_location "adaptor", location
      end

      # 
      # Adds a remote location to the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.add_remote_location("quickset_name").
      #       add_query_term("Greene", "creator", "contains").search
      # 
      def add_remote_location location
        add_location "remote", location
      end
    end
  end
end