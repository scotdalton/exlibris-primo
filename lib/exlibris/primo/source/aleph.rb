module Exlibris
  module Primo
    module Source
      # == Overview
      # Exlibris::Primo::Source::Aleph is an Exlibris::Primo::Holding that provides a link to Aleph
      # and a request link based on config settings in the Primo config file.
      # 
      # == Example Config
      #   source_id:
      #     base_url: http://aleph.library.edu
      #     rest_url: http://aleph.library.edu:1891/rest-dlf
      #     local_base: LOCAL01
      #     requestable_statuses:
      #       - available
      #       - request_ill
      #     sub_library_codes:
      #       PrimoLibrary1: AlephSubLibrary1
      #       PrimoLibrary2: AlephSubLibrary1
      #       PrimoLibrary3: AlephSubLibrary2
      # 
      class Aleph < Exlibris::Primo::Holding

        # Overwrites Exlibris::Primo::Holding#new
        def initialize(attributes={})
          super attributes
          @source_data.merge!({
            :doc_library => original_source_id,
            :sub_library_code => sub_library_code,
            :sub_library => sub_library,
            :collection => collection,
            :call_number => call_number,
            :doc_number => source_record_id,
            :rest_api_id => ils_api_id })
        end

        # Aleph base url from config.
        def aleph_url
          @aleph_url ||= source_config["base_url"] unless source_config.nil?
        end

        # Aleph base rest url from config.
        def aleph_rest_url
          @aleph_rest_url ||= source_config["rest_url"] unless source_config.nil?
        end

        # Aleph local base from config.
        def local_base
          @local_base ||= source_config["local_base"] unless source_config.nil?
        end

        # Aleph holdings screen
        def url
          @url ||= "#{aleph_url}/F?func=item-global&doc_library=#{original_source_id}&local_base=#{local_base}&doc_number=#{source_record_id}&sub_library=#{sub_library_code}"
        end

        # Aleph doesn't work right so we have to push the patron to the Aleph holdings page!
        def request_url
          @request_url = url if requestable?
        end

        # Aleph record rest url
        def rest_url
          @rest_url ||= "#{aleph_rest_url}/record/#{ils_api_id}"
        end

        # Aleph sub library code from config based on library code
        def sub_library_code
          @sub_library_code ||= sub_library_codes[library_code] unless sub_library_codes.nil?
        end

        # Aleph sub library
        def sub_library
          library
        end

        # Aleph sub library codes from config to map from Primo libraries to Aleph sub libraries
        def sub_library_codes
          @sub_library_codes ||= source_config["sub_library_codes"] unless source_config.nil?
        end
        private :sub_library_codes

        # Aleph requestable statuses from config
        def requestable_statuses
          source_config["requestable_statuses"] unless source_config.nil?
        end
        private :requestable_statuses

        # Is this holding requestable?
        def requestable?
          (requestable_statuses.nil?) ? false : requestable_statuses.include?(@availability_status_code)
        end
        private :requestable?
      end
    end
  end
end