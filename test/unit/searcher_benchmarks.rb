require 'test_helper'
class SearcherTest < Test::Unit::TestCase
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
        - cover_image })
    @base_url = @primo_definition["base_url"]
    @vid = @primo_definition["vid"]
    @institution = @primo_definition["institution"]
    @primo_holdings_doc_id = "nyu_aleph000062856"
    @primo_rsrcs_doc_id = "nyu_aleph002895625"
    @primo_tocs_doc_id = "nyu_aleph003149772"
    @primo_dedupmrg_doc_id = "dedupmrg17343091"
    @primo_test_checked_out_doc_id = "nyu_aleph000089771"
    @primo_test_offsite_doc_id = "nyu_aleph002169696"
    @primo_test_ill_doc_id = "nyu_aleph001502625"
    @primo_test_diacritics1_doc_id = "nyu_aleph002975583"
    @primo_test_diacritics2_doc_id = "nyu_aleph003205339"
    @primo_test_diacritics3_doc_id = "nyu_aleph003365921"
    @primo_test_journals1_doc_id = "nyu_aleph002895625"
    @primo_invalid_doc_id = "thisIsNotAValidDocId"
    @primo_test_problem_doc_id = "nyu_aleph000509288"
    @primo_test_bug1361_id = "ebrroutebr10416506"
    @primo_test_isbn = "0143039008"
    @primo_test_title = "Travels with My Aunt"
    @primo_test_author = "Graham Greene"
    @primo_test_genre = "Book"
    @searcher_setup = {
      :base_url => @base_url,
      :institution => @institution,
      :vid => @vid,
      :config => @primo_definition
    }
  end
  
  def testbenchmarks
    Benchmark.bmbm do |results|
      results.report("Primo Searcher:") {
        (1..10).each {
          searcher = Exlibris::Primo::Searcher.new(@searcher_setup, {:primo_id => @primo_holdings_doc_id})
        }
      }
      searcher = Exlibris::Primo::Searcher.new(@searcher_setup, {:primo_id => @primo_holdings_doc_id})
      results.report("Searcher#process_record") {
        (1..10).each {
          searcher.send(:process_record)
        }
      }
      results.report("Searcher#process_search_results") {
        (1..10).each {
          searcher.send(:process_search_results)
        }
      }
    end
  end
end