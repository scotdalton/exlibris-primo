module Exlibris
  module Primo
    # == Overview
    # Exlibris::Primo::EShelf provides access to the Primo Eshelf for a given user.
    # An instance of Exlibris::Primo::EShelf can be created by passing
    # in a hash with setup parameters, a user_id and an institution.
    # Valid setup parameters include:
    #   :base_url, :resolver_base_url, :vid, :config
    #
    # == Examples of usage
    #   Exlibris::Primo::EShelf.new({ :base_url => "http://primo.institution.edu", :vid => "VID", :resolver_base_url => "http://resolver.institution.edu"} , "USER_ID", "PRIMO").count
    #   Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute).basket_id
    class EShelf
      
      #Namespaces
      SEAR_NS = {'sear' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
      PRIM_NS = {'prim' => 'http://www.exlibris.com/primo/xsd/primoeshelffolder'}
      
      def initialize(setup, user_id, institution)
        @base_url = setup[:base_url]
        raise_required_setup_parameter_error :base_url if @base_url.nil?
        @resolver_base_url = setup[:resolver_base_url]
        @vid = setup.fetch(:vid, "DEFAULT")
        raise_required_setup_parameter_error :vid if @vid.nil?
        @config = setup.fetch(:config, {})
        raise_required_setup_parameter_error :config if @config.nil?
        @user_id = user_id
        raise_required_setup_parameter_error :user_id if @user_id.nil?
        @institution = institution
        raise_required_setup_parameter_error :institution if @institution.nil?
        @records = []
      end
    
      # Call Web Service to get Eshelf contents and return
      def eshelf
        @eshelf ||= Exlibris::Primo::WebService::GetEShelf.new(@user_id, @institution, @base_url).response
      end
      
      # Call Web Service to get Eshelf structure and return
      def eshelfStructure
        @eshelfStructure ||= Exlibris::Primo::WebService::GetEShelfStructure.new(@user_id, @institution, @base_url).response
      end
      
      # Fetch the number of records in user's Eshelf
      def count
        @count ||= Integer(eshelf.at("//sear:DOCSET", SEAR_NS)["TOTALHITS"])
      end
    
      # Fetch all records from user's Eshelf as an array of Primo Record objects
      def records    
        eshelf.search("//sear:DOC", SEAR_NS).each { |doc|
          @records.push(Record.new({ :base_url => @base_url, :resolver_base_url => @resolver_base_url, :vid => @vid, :record => doc.at("//xmlns:record", doc.namespaces), :institution => @institution }))
        } if @records.empty?
        return @records
      end
      
      # Fetch default basket id from eshelf structure web service call
      def basket_id
        @basket_id ||= eshelfStructure.at(
          "//prim:eshelf_folders//prim:eshelf_folder[./prim:folder_name='Basket']", PRIM_NS).
          get_attribute("folder_id") unless eshelfStructure.at("//prim:eshelf_folders//prim:eshelf_folder[./prim:folder_name='Basket']", PRIM_NS).nil?
      end
      
      # Call Web Service to add records to remote Eshelf
      def add_records(doc_ids, folder_id)
        Exlibris::Primo::WebService::AddToEShelf.new(doc_ids, folder_id, @user_id, @institution, @base_url) unless doc_ids.empty?
      end

      # Call Web Service to remove records from remote EShelf
      def remove_records(doc_ids, folder_id)
        Exlibris::Primo::WebService::RemoveFromEShelf.new(doc_ids, folder_id, @user_id, @institution, @base_url) unless doc_ids.empty?
      end
      
      private
      def raise_required_setup_parameter_error(parameter)
        raise ArgumentError.new("Error in #{self.class}. Missing required setup parameter: #{parameter}.")
      end
    end
  end
end