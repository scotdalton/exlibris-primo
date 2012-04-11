require 'test_helper'

class WebServiceTest < ActiveSupport::TestCase
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
  
  test "bogus_response" do
    assert_raise(SOAP::HTTPStreamError) {
      ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @bogus_404_url)
    }
    assert_raise(SOAP::HTTPStreamError) {
      ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @bogus_200_url)
    }
  end
  
  # Test GetRecord for a single Primo document.
  test "get_record" do
    ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_equal(@primo_test_doc_id, ws.response.at("//pnx:control/pnx:recordid", PNX_NS).inner_text, "#{ws.class} returned an unexpected record: #{ws.response.to_xml(:indent => 5, :encoding => 'UTF-8')}")
  end
  
  test "get_record_count" do
    ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @base_url)
    assert_equal("1", ws.response.at("//search:DOCSET", SEARCH_NS)["TOTALHITS"])
  end
  
  test "search_brief_count" do
    ws = Exlibris::Primo::WebService::SearchBrief.new(@isbn_search_params, @base_url)
    assert_equal("1", ws.response.at("//search:DOCSET", SEARCH_NS)["TOTALHITS"])
  end
  
  test "get_genre_discrepancy" do
    ws = Exlibris::Primo::WebService::GetRecord.new(@primo_test_problem_doc_id, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_equal(@primo_test_problem_doc_id, ws.response.at("//pnx:control/pnx:recordid", PNX_NS).inner_text, "#{ws.class} returned an unexpected record: #{ws.response.to_xml(:indent => 5, :encoding => 'UTF-8')}")
    assert_not_nil(ws.response.at("//pnx:display/pnx:availlibrary", PNX_NS).inner_text, "#{ws.class} returned an unexpected record: #{ws.response.to_xml(:indent => 5, :encoding => 'UTF-8')}")
  end
  
  # Test GetRecord with invalid Primo doc id.
  test "get_bogus_record" do
    assert_raise(RuntimeError) {
      ws = Exlibris::Primo::WebService::GetRecord.new(@primo_invalid_doc_id, @base_url)
    }
  end
  
  # Test SearchBrief by isbn.
  test "isbn_search" do
    ws = Exlibris::Primo::WebService::SearchBrief.new(@isbn_search_params, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by issn.
  test "issn_search" do
    ws = Exlibris::Primo::WebService::SearchBrief.new(@issn_search_params, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by title.
  test "title_search" do
    ws = Exlibris::Primo::WebService::SearchBrief.new(@title_search_params, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by author.
  test "author_search" do
    ws = Exlibris::Primo::WebService::SearchBrief.new(@author_search_params, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end
  
  # Test SearchBrief by title/author/genre.
  test "title_author_genre_search" do
    ws = Exlibris::Primo::WebService::SearchBrief.new(@title_author_genre_search_params, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
  end 
  
  test "get_new_eshelf" do
    ws = Exlibris::Primo::WebService::GetEShelf.new(@valid_user_id, @default_institution, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_not_nil(ws.response.at("//sear:DOC", SEAR_NS), "#{ws.class} response returned a nil document")
  end
  
  test "get_new_eshelf_structure" do
    ws = Exlibris::Primo::WebService::GetEShelfStructure.new(@valid_user_id, @default_institution, @base_url)
    assert_not_nil(ws, "#{ws.class} returned nil when instantiated.")
    assert_instance_of( Nokogiri::XML::Document, ws.response, "#{ws.class} response is an unexpected object: #{ws.response.class}")
    assert_equal([], ws.error, "#{ws.class} encountered errors: #{ws.error}")
    assert_not_nil(ws.response.at("//prim:eshelf_folders", PRIM_NS), "#{ws.class} response returned a nil document")
  end

end