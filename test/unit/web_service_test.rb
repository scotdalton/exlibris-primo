require 'test_helper'

class WebServiceTest < Test::Unit::TestCase
  PNX_NS = {'pnx' => 'http://www.exlibrisgroup.com/xsd/primo/primo_nm_bib'}
  SEARCH_NS = {'search' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
  SEAR_NS = {'sear' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
  PRIM_NS = {'prim' => 'http://www.exlibris.com/primo/xsd/primoeshelffolder'}
  
  def setup
    @primo_definition = YAML.load( %{
        type: PrimoService
        priority: 2 # After SFX, to get SFX metadata enhancement
        status: active
        base_url: http://bobcatdev.library.nyu.edu
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
    
    @valid_user_id = "N18158418"
    @invalid_user_id = "INVALID_USER"
    @default_institution = "NYU"
    @base_url = @primo_definition["base_url"]
    @bogus_404_url = "http://library.nyu.edu/bogus"
    @bogus_200_url = "http://library.nyu.edu"
    @primo_test_doc_id = "nyu_aleph000062856"
    @primo_invalid_doc_id = "thisIsNotAValidDocId"
    @primo_test_problem_doc_id = "nyu_aleph000509288"
    @isbn_search_params = {:isbn => "0143039008"}
    @issn_search_params = {:issn => "0090-5720"}
    @title_search_params = {:title => "Travels with My Aunt"}
    @author_search_params = {:author => "Graham Greene"}
    @title_author_genre_search_params = {:title => "Travels with My Aunt", :author => "Graham Greene", :genre => "Book"}
  end
  
  def testbogus_response
    assert_raise(SOAP::HTTPStreamError) {
      ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @bogus_404_url)
    }
    assert_raise(SOAP::HTTPStreamError) {
      ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @bogus_200_url)
    }
  end
  
  # Test GetRecord for a single Primo document.
  def testget_record
    ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_equal(@primo_test_doc_id, ws.response.at("//pnx:control/pnx:recordid", PNX_NS).inner_text, "#{ws.class} returned an unexpected record: #{ws.response.to_xml(:indent => 5, :encoding => 'UTF-8')}")
  end
  
  def testget_record_count
    ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @base_url, {:institution => "NYU"})
    assert_equal("1", ws.response.at("//search:DOCSET", SEARCH_NS)["TOTALHITS"])
  end
  
  def testsearch_brief_count
    ws = Exlibris::Primo::WebService::SearchBrief.new(@isbn_search_params, @base_url, {:institution => "NYU"})
    assert_equal("1", ws.response.at("//search:DOCSET", SEARCH_NS)["TOTALHITS"])
  end
  
  def testget_genre_discrepancy
    ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_problem_doc_id, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_equal(@primo_test_problem_doc_id, ws.response.at("//pnx:control/pnx:recordid", PNX_NS).inner_text, "#{ws.class} returned an unexpected record: #{ws.response.to_xml(:indent => 5, :encoding => 'UTF-8')}")
    assert_not_nil(ws.response.at("//pnx:display/pnx:availlibrary", PNX_NS).inner_text, "#{ws.class} returned an unexpected record: #{ws.response.to_xml(:indent => 5, :encoding => 'UTF-8')}")
  end
  
  # Test GetRecord with invalid Primo doc id.
  def testget_bogus_record
    assert_raise(RuntimeError) {
      ws = Exlibris::Primo::WebService::GetRecord.new(@primo_invalid_doc_id, @base_url, {:institution => "NYU"})
    }
  end
  
  # Test SearchBrief by isbn.
  def testisbn_search
    ws = Exlibris::Primo::WebService::SearchBrief.new(@isbn_search_params, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by issn.
  def testissn_search
    ws = Exlibris::Primo::WebService::SearchBrief.new(@issn_search_params, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by title.
  def testtitle_search
    ws = Exlibris::Primo::WebService::SearchBrief.new(@title_search_params, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by author.
  def testauthor_search
    ws = Exlibris::Primo::WebService::SearchBrief.new(@author_search_params, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by title/author/genre.
  def testtitle_author_genre_search
    ws = Exlibris::Primo::WebService::SearchBrief.new(@title_author_genre_search_params, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end 
  
  def testget_new_eshelf
    ws = Exlibris::Primo::WebService::GetEShelf.new(@valid_user_id, @default_institution, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_not_nil(ws.response.at("//sear:DOC", SEAR_NS), "#{ws.class} response returned a nil document")
  end
  
  def testget_new_eshelf_structure
    ws = Exlibris::Primo::WebService::GetEShelfStructure.new(@valid_user_id, @default_institution, @base_url, {:institution => "NYU"})
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_not_nil(ws.response.at("//prim:eshelf_folders", PRIM_NS), "#{ws.class} response returned a nil document")
  end
end