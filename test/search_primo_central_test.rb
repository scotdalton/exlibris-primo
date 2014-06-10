require 'test_helper'
class SearchPrimoCentralTest < Test::Unit::TestCase
  def setup
    @base_url = "http://primo-fe1.library.nd.edu:1701"
    @institution = "NDU"
    @search_term = "van gogh"
    @mla_doc_id = "mla2012444463"
  end

  def test_primo_central
    VCR.use_cassette('search primo central') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).add_adaptor_location('primo_central_multiple_fe').any_contains(@search_term)
      assert_not_nil search.records
      assert((not search.records.empty?))
      assert_not_nil search.size
      search.records.each do |record|
        assert record.respond_to?(:display_title), "Record should have a display title"
        assert_not_nil record.display_title
        assert_not_nil record.fulltexts
        assert_not_nil record.tables_of_contents
        assert_not_nil record.related_links
      end
    end
  end

  def test_mla_source
    VCR.use_cassette('search primo central mla') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).add_adaptor_location('primo_central_multiple_fe').add_query_term(@mla_doc_id, "rid", "exact").on_campus
      assert_not_nil search.records
      assert((not search.records.empty?))
      assert_not_nil search.size
      record = search.records.first
      assert record.respond_to?(:display_title), "Record should have a display title"
      assert_not_nil record.display_title
      assert_not_nil record.fulltexts
      assert_not_nil record.tables_of_contents
      assert_not_nil record.related_links
      assert_equal "MLA International Bibliography<img src=\"http://exlibris-pub.s3.amazonaws.com/mlalogo_001.jpg\" style=\"vertical-align:middle;margin-left:7px\">", record.display_source
    end
  end
end
