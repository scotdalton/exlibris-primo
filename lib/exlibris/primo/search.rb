module Exlibris
  module Primo
    #
    # Search Primo using Exlibris::Primo::Search
    # 
    # 
    #     search = Search.new.base_url=("http://primo.library.edu").
    #       add_query_term("Digital divide", "any", "contains")
    #     search.records => Array of Primo records
    #     search.facets => Array of Primo facets
    #     search.size => Total number of records in the search
    # 
    # There are a several configuration setting for the search
    #  
    #     search = Search.new.base_url=("http://primo.library.edu").institution=("PRIMO").
    #       enable_did_u_mean.on_campus.page_size=(20).start_index=(21).add_sort_by("stitle")
    #       add_query_term("Digital divide", "any", "contains")
    #     search.records => Array of Primo records
    #     search.facets => Array of Primo facets
    #     search.size => Total number of records in the search
    # 
    class Search
      include BaseAttributes
      include Config::Attributes
      include RequestAttributes
      include SearchAttributes
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