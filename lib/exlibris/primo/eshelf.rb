module Exlibris
  module Primo
    class EShelf
      
      PNX_NS = {'pnx' => 'http://www.exlibrisgroup.com/xsd/primo/primo_nm_bib'}
      SEARCH_NS = {'search' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
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
    
      def eshelf
        @eshelf ||= Exlibris::Primo::WebService::GetEShelf.new(@user_id, @institution, @base_url).response
      end
      
      def eshelfStructure
        @eshelfStructure ||= Exlibris::Primo::WebService::GetEShelfStructure.new(@user_id, @institution, @base_url).response
      end
      
      def count
        @count ||= Integer(eshelf.at("//sear:DOCSET", SEAR_NS)["TOTALHITS"])
      end
    
      def records    
        eshelf.search("//sear:DOC", SEAR_NS).each { |doc|
          @records.push(Record.new({ :base_url => @base_url, :resolver_base_url => @resolver_base_url, :vid => @vid, :record => doc.at("//xmlns:record", doc.namespaces), :institution => @institution }))
        } if @records.empty?
        return @records
      end
      
      def basket_id
        @basket_id ||= eshelfStructure.at(
          "//prim:eshelf_folders//prim:eshelf_folder[./prim:folder_name='Basket']", PRIM_NS).
          get_attribute("folder_id") unless eshelfStructure.at("//prim:eshelf_folders//prim:eshelf_folder[./prim:folder_name='Basket']", PRIM_NS).nil?
      end
      
      def add_records(doc_ids, folder_id)
        Exlibris::Primo::WebService::AddToEShelf.new(doc_ids, folder_id, @user_id, @institution, @base_url) unless doc_ids.empty?
      end

      def remove_records(doc_ids, folder_id)
        Exlibris::Primo::WebService::RemoveFromEShelf.new(doc_ids, folder_id, @user_id, @institution, @base_url) unless doc_ids.empty?
      end
      
      private
      def folders_to_tags(folders=[])
        tags = []
        folders.each do |folder|
          attribute = folder.get_attribute("folderName") if folder.has_attribute?("folderName")
          tags.push(attribute) unless attribute.nil? or attribute.eql? "Basket"
        end
        return tags.join(",")
      end

      def folder_id(folders=[])
        @folder_id ||= folders.first.get_attribute("folderId") unless folders.nil? or folders.first.nil?
      end

      def raise_required_setup_parameter_error(parameter)
        raise ArgumentError.new("Error in #{self.class}. Missing required setup parameter: #{parameter}.")
      end
    end
  end
end
