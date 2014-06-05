require 'test_helper'
class SearchPrimoCentralTest < Test::Unit::TestCase
  def setup
    @base_url = "http://primo-fe1.library.nd.edu:1701"
    @institution = "NDU"
    @search_term = "van gogh"
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
end
