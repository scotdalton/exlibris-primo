module Exlibris
  module Primo
    # == Overview
    # Module for calling Primo Web Services
    # Please note the following:
    # * Be sure to configure the Primo Back Office with the relevant IPs to enable interaction via the Web Services
    # * This module does not parse the response but instead stores it as an Nokogiri::XML::Document for the calling classes to parse
    module WebService
      require 'nokogiri'
      require 'rexml/document'

      # WebServiceBase is the base class for all Primo Web Services
      # It can be extended but is not intended for use by itself
      # To call a PrimoWebService implementing classes must explicity 
      # call the method make_call.
      class WebServiceBase
        attr_reader :response, :error

        # Call to web service is made through make_call
        # Raise a method not found exception if the method name is not valid
        # def make_call(base_url, service, method_name, param_name, input)
        #   require 'savon'
        #   client = Savon::Client.new do |wsdl|
        #     wsdl.document = "#{base_url}/PrimoWebServices/services/primo/#{service}?wsdl"
        #     wsdl.namespace = "http://www.exlibris.com/primo/xsd/wsRequest"
        #   end
        #   response = client.request :wsdl, method_name do
        #     soap.version = 1
        #     soap.body = input.to_s
        #   end
        #   @response = Nokogiri::XML(response.to_xml)
        #   raise "Error making call to Primo web service.  Response from web service is #{@response}." if @response.nil?
        #   @error = []
        #   response.search("ERROR").each do |e|
        #     # Primo Web Service calls will return an <ERROR MESSAGE="{MESSAGE}" CODE="{CODE}" />
        #     # tag even when it succeeds. Key off CODE == 0 which is a successful call.
        #     #debugger
        #     @error.push(e.attributes["MESSAGE"]) unless e.nil? or e.attributes["CODE"].value.to_i == 0
        #   end
        #   raise "Error making call to Primo web service.  #{@error.inspect}" unless @error.empty?
        # end
        def make_call(base_url, service, method_name, param_name, input)
          require 'soap/rpc/driver'
          endpoint_url = base_url + "/PrimoWebServices/services/primo/" + service
          soap_client = SOAP::RPC::Driver.new(endpoint_url, "http://www.exlibris.com/primo/xsd/wsRequest", "")
          soap_client.add_method(method_name, param_name) unless (respond_to? method_name)
          puts input.to_s
          @response = Nokogiri::XML(soap_client.method(method_name).call(input.to_s))
          raise "Error making call to Primo web service.  Response from web service is #{@response}." if @response.nil?
          @error = []
          response.search("ERROR").each do |e|
            # Primo Web Service calls will return an <ERROR MESSAGE="{MESSAGE}" CODE="{CODE}" />
            # tag even when it succeeds. Key off CODE == 0 which is a successful call.
            #debugger
            @error.push(e.attributes["MESSAGE"]) unless e.nil? or e.attributes["CODE"].value.to_i == 0
          end
          raise "Error making call to Primo web service.  #{@error.inspect}" unless @error.empty?
        end
        
        private
        def tag!(name, value)
          REXML::Element.new(name).add_text(value)
        end
      end

      # Search is the base class for Search web services
      # It can be extended but is not intended for use by itself
      # Two known implementations are SearchBrief and GetRecord
      class Search < WebServiceBase
        # Search is instantiated by calling Search.new with the following parameters
        #   String method_name: web service method being called
        #   String param_name: name of input parameter
        #   String input_root: input root tag name
        #   REXML::Element primo_search_request: REXML:Element representation of the search base on ExL Schema
        #   REXML:Elements[] additional_input: any additional input as an array of REXML::Elements
        #   String base_url: Primo URL
        #   Hash option: options NOT USED 
        def initialize(method_name, param_name, input_root, primo_search_request, additional_input, base_url, options)
          input = REXML::Element.new(input_root)
          input.add_namespace("http://www.exlibris.com/primo/xsd/wsRequest")
          input.add_element(primo_search_request)
          additional_input.each do |e|  
            input.add_element(e)
          end
          make_call(base_url, "searcher", method_name, param_name, input)
        end

        private
        def primo_search_request(search_params={}, start_index="1", bulk_size="5", did_u_mean_enabled="false", highlighting_enabled="false", get_more=nil)
          xml = REXML::Element.new("PrimoSearchRequest")
          xml.add_namespace("http://www.exlibris.com/primo/xsd/search/request")
          xml.add_element(query_terms(search_params))
          xml.add_element(tag!("StartIndex", start_index)) unless start_index.nil?
          xml.add_element(tag!("BulkSize", bulk_size)) unless bulk_size.nil?
          xml.add_element(tag!("DidUMeanEnabled", did_u_mean_enabled))  unless did_u_mean_enabled.nil?
          xml.add_element(tag!("HighlightingEnabled", highlighting_enabled))  unless highlighting_enabled.nil?
          xml.add_element(tag!("GetMore", get_more))  unless get_more.nil?
          return xml
        end

        def query_terms(search_params, bool_operator="AND")
          xml = REXML::Element.new("QueryTerms")
          xml.add_element(tag!("BoolOpeator", bool_operator)) unless bool_operator.nil?
          search_params.each do |m, v|
            begin
              xml.add_element(self.method("#{m}_query_term").call(v))
            rescue Exception => e
              raise "Invalid search params.\nSupported search params are\n\t:isbn\n\t:issn\n\t:title\n\t:author\n\t:genre\n\nException: #{e.inspect}"
            end
          end
          return xml
        end

        def query_term(value=nil, index_field="any", precision_operator="contains")
          xml = REXML::Element.new("QueryTerm")
          xml.add_element(tag!("IndexField", index_field)) unless value.nil?
          xml.add_element(tag!("PrecisionOperator", precision_operator)) unless value.nil?
          xml.add_element(tag!("Value", value)) unless value.nil?
          return xml
        end

        def isbn_query_term(isbn)
          return query_term(isbn, "isbn", "exact")
        end

        def issn_query_term(issn)
          return query_term(issn, "isbn", "exact")
        end

        def title_query_term(title)
          return query_term(title, "title")
        end

        def author_query_term(author)
          return query_term(author, "creator")
        end

        def genre_query_term(genre)
          return query_term(genre, "any", "exact")
        end
      end

      # SearchBrief does a brief result search through the Primo APIs
      # Not all Primo API options are currently supported
      # Supported search params are
      #   :isbn, :issn, :title :author, :genre
      #   e.g. {:isbn => "0143039008", :title => "Travels with My Aunt"}
      # Invalid params will raise an exception
      class SearchBrief < Search
        def initialize(search_params, base_url, options={})
          additional_input=[]
          additional_input.push(tag!("institution", options.delete(:institution))) if options.has_key?(:institution)
          super("searchBrief", "searchBriefRequest", "searchRequest", primo_search_request(search_params), additional_input, base_url, options)
        end
      end

      # GetRecord get a Primo record based on doc id
      # Not all Primo API options are currently supported
      class GetRecord < Search
        def initialize(doc_id, base_url, options={})
          additional_input=[]
          additional_input.push(tag!("docId", doc_id))
          additional_input.push(tag!("institution", options.delete(:institution))) if options.has_key?(:institution)
          super("getRecord", "getRecordRequest", "fullViewRequest", primo_search_request, additional_input, base_url, options)
        end
      end
      
      # EShelf is the base class for EShelf web services
      # It can be extended but is not intended for use by itself
      # Known implementations are GetEShelf, AddToEShelf, RemoveFromEShelf, GetEShelfStructure
      class EShelf < WebServiceBase
        def initialize(method_name, param_name, input_root, user_id, institution, additional_input, base_url, options, service_name = nil)
          input = REXML::Element.new(input_root)
          input.add_namespace("http://www.exlibris.com/primo/xsd/wsRequest")
          input.add_element(tag!("userId", user_id)) if !user_id.nil?
          input.add_element(tag!("institution", institution)) if !institution.nil?
          additional_input.each do |e|  
            input.add_element(e)
          end
          service_name = "eshelf" if service_name.nil?
          make_call(base_url, service_name, method_name, param_name, input)
        end

        private
        def docs(doc_ids=[], folder_id=nil, folder_name=nil)
          additional_input = []
          doc_ids.each { |doc_id| additional_input.push(tag!("docId", doc_id)) }
          additional_input.push(tag!("folderId", folder_id)) unless folder_id.nil?
          additional_input.push(tag!("folderName", folder_name)) unless folder_name.nil?
          return additional_input
        end
      end

      # Get EShelf based on user_id and institution
      class GetEShelf < EShelf
        def initialize(user_id, institution, base_url, options={})
          super("getEshelf", "getEshelfRequest", "getEshelfRequest", user_id, institution, [], base_url, options)
          raise "Error making call to Primo web service.  #{@error.inspect}" unless @error.empty? or @error.attribe
        end
      end

      # Get EShelf structure based on user_id and institution
      class GetEShelfStructure < EShelf
        def initialize(user_id, institution, base_url, options={})
          super("getEshelfStructure", "getEshelfStructureRequest", "getEshelfStructureRequest", user_id, institution, [tag!("includeBasketItems","false")], base_url, options, "eshelfstructure")
          raise "Error making call to Primo web service.  #{@error.inspect}" unless @error.empty? or @error.attribe
        end
      end

      # Add document to EShelf based on user_id and institution
      class AddToEShelf < EShelf
        def initialize(doc_ids, folder_id, user_id, institution, base_url, options={})
          super("addToEshelf", "addToEshelfRequest", "addToEshelfRequest", user_id, institution, docs(doc_ids, folder_id), base_url, options)
        end
      end

      # Remove document from EShelf based on user_id and institution
      class RemoveFromEShelf < EShelf
        def initialize(doc_ids, folder_id, user_id, institution, base_url, options={})
          super("removeFromEshelf", "removeFromEshelfRequest", "removeFromEshelfRequest", user_id, institution, docs(doc_ids, folder_id), base_url, options)
        end
      end
    end
  end
end