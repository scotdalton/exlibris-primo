require 'test_helper'
class SearchTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @isbn = "0143039008"
    @user_id = "N12162279"
    @institution = "NYU"
    @record_id = "nyu_aleph000062856"
  end

  def test_search_isbn
    VCR.use_cassette('search isbn') do
      search = Exlibris::Primo::Search.new(:base_url => @base_url, :institution => @institution, :isbn => @isbn)
      assert_not_nil search.count
      assert_not_nil search.facets
      assert((not search.facets.empty?))
      assert_not_nil search.records
      assert((not search.records.empty?))
      search.records.each do |record|
        assert_not_nil record.holdings
        assert((not record.holdings.empty?))
        assert_not_nil record.fulltexts
        assert_not_nil record.tables_of_contents
        assert_not_nil record.related_links
      end
    end
  end

  def test_search_record_id
    VCR.use_cassette('search record id') do
      search = Exlibris::Primo::Search.new(:base_url => @base_url, :institution => @institution, :record_id => @record_id)
      assert_not_nil search.count
      assert_not_nil search.facets
      assert search.facets.empty?
      assert_not_nil search.records
      assert((not search.records.empty?))
      search.records.each do |record|
        assert_not_nil record.holdings
        assert((not record.holdings.empty?))
        assert_not_nil record.fulltexts
        assert_not_nil record.tables_of_contents
        assert_not_nil record.related_links
      end
    end
  end
end