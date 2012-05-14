require 'test_helper'

class EShelfTest < Test::Unit::TestCase
  PNX_NS = {'pnx' => 'http://www.exlibrisgroup.com/xsd/primo/primo_nm_bib'}
  SEARCH_NS = {'search' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
  SEAR_NS = {'sear' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
  PRIM_NS = {'prim' => 'http://www.exlibris.com/primo/xsd/primoeshelffolder'}

  def setup
      @primo_definition = YAML.load( %{
          type: PrimoService
          priority: 2 # After SFX, to get SFX metadata enhancement
          status: active
          base_url: http://bobcat.library.nyu.edu
          resolver_base_url: https://getit.library.nyu.edu/resolve
          vid: NYU
          institution: NYU
          holding_search_institution: NYU
          holding_search_text: Search for this title in BobCat.
          suppress_holdings: [ !ruby/regexp '/\$\$LBWEB/', !ruby/regexp '/\$\$LNWEB/', !ruby/regexp '/\$\$LTWEB/', !ruby/regexp '/\$\$LWEB/', !ruby/regexp '/\$\$1Restricted Internet Resources/' ]
          ez_proxy: !ruby/regexp '/https\:\/\/ezproxy\.library\.nyu\.edu\/login\?url=/'
          service_types:
            - primo_source
            - holding_search
            - fulltext
            - table_of_contents
            - referent_enhance
            - cover_image
        })

      @base_url = @primo_definition["base_url"]
      @vid = @primo_definition["vid"]
      @valid_user_id = "N18158418"
      @invalid_user_id = "INVALID_USER"
      @eshelf_setup = {
          :base_url => @base_url,
          :vid => @vid,
          :resolver_base_url => @primo_definition["resolver_base_url"]
      }
      @valid_institute = "NYU"
      @invalid_institute = "INVALID_INST"
      @valid_doc_ids = ["nyu_aleph000062856"]
      @invalid_doc_ids = ["INVALID_DOC_ID"]
      @valid_basket = "298560007"
      #@valid_folder = "344619707"
      @invalid_basket = "INVALID_BASKET"
  end

  def test_new
      eshelf = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute)
      assert_not_nil(eshelf, "#{eshelf.class} returned nil when instantiated.")
   
      assert_equal(@base_url, eshelf.instance_variable_get(:@base_url))
      assert_equal(@vid, eshelf.instance_variable_get(:@vid))
      assert_equal(@valid_user_id, eshelf.instance_variable_get(:@user_id))
      assert_equal(@valid_institute, eshelf.instance_variable_get(:@institution))
    
      assert_nothing_raised{Exlibris::Primo::EShelf.new({:base_url => @base_url}, @valid_user_id, @valid_institute)}
      assert_nothing_raised{Exlibris::Primo::EShelf.new({:base_url => @base_url, :vid => @vid}, @valid_user_id, @valid_institute)}
      
      assert_raise(ArgumentError){Exlibris::Primo::EShelf.new({}, @valid_user_id, @valid_institute)}
      assert_raise(ArgumentError){Exlibris::Primo::EShelf.new(@eshelf_setup, nil, nil)}
      assert_raise(ArgumentError){Exlibris::Primo::EShelf.new(@eshelf_setup, nil, nil)}
      assert_raise(ArgumentError){Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, nil)}

  end

  def test_valid_eshelf
      eshelf = nil
      assert_nothing_raised{eshelf = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute).eshelf}
      assert_not_nil(eshelf)
      assert_instance_of(Nokogiri::XML::Document, eshelf)
  end

  def test_valid_eshelf_structure
      eshelfStructure = nil
      assert_nothing_raised{eshelfStructure = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute).eshelfStructure}
      assert_not_nil(eshelfStructure)
      assert(eshelfStructure.is_a? Nokogiri::XML::Document)
  end
  
  def test_basket_id
      assert_equal(@valid_basket, Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute).basket_id)
  end

  def test_invalid_user_eshelf
      ws = nil
      assert_nothing_raised(){ws = Exlibris::Primo::EShelf.new(@eshelf_setup, @invalid_user_id, @valid_institute)}
      assert_not_nil(ws)
      eshelf = nil
      assert_nothing_raised(){eshelf = ws.eshelf}
      assert_not_nil(eshelf)
      assert_instance_of(Nokogiri::XML::Document, eshelf)
      assert_equal(0, ws.count)
  end
  
  def test_invalid_institution_eshelf
      ws = nil
      assert_nothing_raised(){ws = Exlibris::Primo::EShelf.new(@eshelf_setup, @invalid_user_id, @valid_institute)}
      assert_not_nil(ws)
      eshelf = nil
      assert_nothing_raised(){eshelf = ws.eshelf}
      assert_not_nil(eshelf)
      assert_instance_of(Nokogiri::XML::Document, eshelf)
      assert_equal(0, ws.count)
  end

  def test_records
      records = nil
      assert_nothing_raised(){records = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute).records}
      assert_not_nil(records)
      assert_instance_of(Array, records)
      assert(!records.empty?, "Eshelf records returned empty")
  end

  def test_cant_add_same_record_twice
      eshelf = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute)
      assert_not_nil(eshelf)
      # Add record
      assert_nothing_raised(){ eshelf.add_records(@valid_doc_ids, @valid_basket) }
      # Add same record again
      assert_raise(RuntimeError){ eshelf.add_records(@valid_doc_ids, @valid_basket) }
      # Remove record
      assert_nothing_raised(){ eshelf.remove_records(@valid_doc_ids, @valid_basket) }
  end
  
  def test_cant_add_invalid_records
      eshelf = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute)
      assert_not_nil(eshelf)
      # Attempt to add record
      assert_raise(RuntimeError){ eshelf.add_records(@invalid_doc_ids, @valid_basket) }
      # Attempt to remove record which was never added
      assert_raise(RuntimeError){ eshelf.remove_records(@invalid_doc_ids, @valid_basket) }
  end
  
  def test_cant_add_to_invalid_basket
      eshelf = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute)
      assert_not_nil(eshelf)
      # Attempt to add record to basket with invalid folder name
      assert_raise(RuntimeError){ eshelf.add_records(@valid_doc_ids, @invalid_basket) }
  end
  
  def test_can_add_to_empty_folder
      eshelf = Exlibris::Primo::EShelf.new(@eshelf_setup, @valid_user_id, @valid_institute)
      assert_not_nil(eshelf)
      # Add record to basket with no folder id
      assert_nothing_raised(){ eshelf.add_records(@valid_doc_ids, nil) }
      # Remove record from basket with no folder id
      assert_nothing_raised(){ eshelf.remove_records(@valid_doc_ids, @valid_basket) }
  end
end