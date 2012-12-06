module Exlibris
  module Primo
    module ChainGang
      # = Primo ChainGang Search
      # These search attributes are included in
      # Exlibris::Primo::Search and allow for chaining methods together.
      #
      # == Examples
      #
      #     Search.new.title("Travels", "title", "contains").
      #           and.add_query_term("Greene", "creator", "contains").search
      #
      module Search
        def self.included(klass)
          klass.class_eval do
            extend ClassAttributes
          end
        end

        module ClassAttributes
          def indexes
            @indexes ||= [:any, :stitle, :title, :creator, :genre, :author, :isbn]
          end

          def indexes_map
            @indexes_map ||= {:author => :creator}
          end

          def precisions
            @precisions ||= [:is, :begins_with, :contains, :starts_with]
          end

          def precisions_map
            @precisions_map ||= {:is => :exact, :starts_with => :begins_with}
          end
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
        #     Search.new.add_query_term("Travels", "title", "begins_with").
        #       add_query_term("Greene", "creator", "contains").search
        #
        def add_query_term(*args)
          search_request.add_query_term(*args)
          self
        end

        # 
        # Dynamically sets chainable accessor for indexes and 
        # precisions
        # Suitable for chaining, e.g.
        #
        #     Search.new.title_begins_with("Travels").
        #       creator_contains("Greene").search
        # 
        def method_missing(method, *args, &block)
          if matches? method
            self.class.send(:define_method, method) { |value|
              index = indexize(method)
              index = (indexes_map[index] || index)
              precision = precisionize(method)
              precision = (precisions_map[precision] || precision)
              add_query_term value, index, precision
            }
            send method, *args, &block
          else
            super
          end
        end

        # Returns true if the method can be evaluated to a method name
        # and parameter.
        def respond_to? method, include_private=false
          if(matches? method)
            return true
          else
            super
          end
        end

        # Supported indexes
        def indexes
          @indexes ||= self.class.indexes
        end
        private :indexes

        # Alternative indexes mapping
        def indexes_map
          @indexes_map ||= self.class.indexes_map
        end
        private :indexes_map

        # Supported precisions
        def precisions
          @precisions ||= self.class.precisions
        end
        private :precisions

        # Alternative precisions mapping
        def precisions_map
          @precisions_map ||= self.class.precisions_map
        end
        private :precisions_map

        # Get the index from the method.
        def indexize(method)
          parse_method(method).first.to_sym
        end
        private :indexize

        # Get the precision from the method.
        def precisionize(method)
          parse_method(method).last.to_sym
        end
        private :precisionize

        # Parse the method on the first occurence of delimiter.
        def parse_method(method, delimiter="_")
          method.to_s.split(delimiter, 2)
        end
        private :parse_method

        # Does this match our indexes and precisions.
        def matches? method
          indexes.include? indexize(method) and precisions.include? precisionize(method)
        end
        private :matches?

        #
        # Set start index for the search.
        # Suitable for chaining, e.g.
        #
        #     Search.new.start_index!(11).
        #       add_query_term("Digital divide", "any", "contains").
        #         search.records.first => 11th record from the search
        #
        def start_index!(start_index)
          request_attributes[:start_index] = "#{start_index}"
          self
        end
        alias :start_index= :start_index!

        #
        # Set page size for the search.
        # Suitable for chaining, e.g.
        #
        #     Search.new.page_size!(10).
        #       add_query_term("Digital divide", "any", "contains").
        #         search.records.size => 10
        #
        def page_size!(page_size)
          request_attributes[:bulk_size] = "#{page_size}"
          self
        end
        alias :page_size= :page_size!

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
        def add_language(*args)
          search_request.add_language(*args)
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
        def add_sort_by(*args)
          search_request.add_sort_by(*args)
          self
        end

        #
        # Adds a display field (for highlighting) to the search.
        # Suitable for chaining, e.g.
        #
        #     Search.new.add_display_field("creator").
        #       add_query_term("Greene", "creator", "contains").search
        #
        def add_display_field(*args)
          search_request.add_display_field(*args)
          self
        end

        #
        # Adds a location to the search.
        # Suitable for chaining, e.g.
        #
        #     Search.new.add_location("local", "scope:(VOLCANO)").
        #       add_query_term("Greene", "creator", "contains").search
        #
        def add_location(*args)
          search_request.add_location(*args)
          self
        end

        #
        # Adds a local location to the search.
        # Suitable for chaining, e.g.
        #
        #     Search.new.add_local_location("scope:(VOLCANO)").
        #       add_query_term("Greene", "creator", "contains").search
        #
        def add_local_location(location)
          add_location("local", location)
        end

        #
        # Adds an adaptor location to the search.
        # Suitable for chaining, e.g.
        #
        #     Search.new.add_adaptor_location("primo_central_multiple_fe").
        #       add_query_term("Greene", "creator", "contains").search
        #
        def add_adaptor_location(location)
          add_location("adaptor", location)
        end

        #
        # Adds a remote location to the search.
        # Suitable for chaining, e.g.
        #
        #     Search.new.add_remote_location("quickset_name").
        #       add_query_term("Greene", "creator", "contains").search
        #
        def add_remote_location(location)
          add_location("remote", location)
        end
      end
    end
  end
end