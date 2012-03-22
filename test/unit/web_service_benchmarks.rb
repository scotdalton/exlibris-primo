require 'test_helper'

class WebServiceBenchmarks < ActiveSupport::TestCase
  PNX_NS = {'pnx' => 'http://www.exlibrisgroup.com/xsd/primo/primo_nm_bib'}
  SEARCH_NS = {'search' => 'http://www.exlibrisgroup.com/xsd/jaguar/search'}
  
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
  
  test "benchmarks" do
    Benchmark.bmbm do |results|
      results.report("Get Record:") { 
        (1..10).each {
          get_record = Exlibris::Primo::WebService::GetRecord.new(@primo_test_doc_id, @base_url) 
        }
      }
      results.report("SearchBrief by ISBN:") { 
        (1..10).each {
          get_record = Exlibris::Primo::WebService::SearchBrief.new(@isbn_search_params, @base_url)
        }
      }
      results.report("SearchBrief by title:") { 
        (1..10).each {
          get_record = Exlibris::Primo::WebService::SearchBrief.new(@title_search_params, @base_url)
        }
      }
    end
  end
end