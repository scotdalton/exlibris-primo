module Exlibris
  module Primo
    module BaseAttributes
      # 
      # Set base URL for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.base_url!("http://primo.library.edu").
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def base_url!(base_url)
        @base_url = base_url
        request_attributes[:base_url] = "#{base_url}"
        self
      end
      alias :base_url= :base_url!

      # 
      # Set institution for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.institution!("PRIMO").
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def institution!(institution)
        @institution = institution
        request_attributes[:institution] = "#{institution}"
        self
      end
      alias :institution= :institution!

      # 
      # Set client IP for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.ip!("127.0.0.1").
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def ip!(ip)
        request_attributes[:ip] = "#{ip}"
        self
      end
      alias :ip= :ip!
      alias :client_ip! :ip!
      alias :client_ip= :ip!

      # 
      # Set the group for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.group!("Department").
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def group!(group)
        request_attributes[:group] = "#{group}"
        self
      end
      alias :group= :group!

      # 
      # Set the PDS handle for the search.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.pds_handle!("PDS_HANDLE").
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def pds_handle!(pds_handle)
        request_attributes[:pds_handle] = "#{pds_handle}"
        self
      end
      alias :pds_handle= :pds_handle!

      # 
      # Specifies that the search is coming from on campus.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.on_campus.
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def on_campus
        request_attributes[:on_campus] = "true"
        self
      end

      # 
      # Specifies that the search is coming from off campus.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.off_campus.
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def off_campus
        request_attributes[:on_campus] = "false"
        self
      end

      # 
      # Specifies that the search user is logged in.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.logged_in.
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def logged_in
        request_attributes[:is_logged_in] = "true"
        self
      end

      # 
      # Specifies that the search user is logged out.
      # Suitable for chaining, e.g. 
      # 
      #     Search.new.logged_out.
      #       add_query_term("Digital divide", "any", "contains").search
      # 
      def logged_out
        request_attributes[:is_logged_in] = "false"
        self
      end
    end
  end
end