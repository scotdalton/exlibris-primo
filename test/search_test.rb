require 'test_helper'
class SearchTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @isbn = "0143039008"
    @user_id = "N12162279"
    @institution = "NYU"
    @record_id = "nyu_aleph000062856"
    @title = "Travels with My Aunt"
    @author = "Graham Greene"
    @title_starts_with = "Travels"
    @author_contains = "Greene"
  end

  def test_chaining
    VCR.use_cassette('search chaining isbn') do
      search = Exlibris::Primo::Search.new();
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).isbn_is(@isbn)
      assert_not_nil search.size
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
  
  def test_chaining_author_title
    VCR.use_cassette('search chaining author title') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).author_is(@author).and.title_is(@title)
      assert_not_nil search.size
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
  
  def test_chaining_contains_author_starts_with_title
    VCR.use_cassette('search chaining contains author starts with title') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).author_contains(@author_contains).and.stitle_starts_with(@title_starts_with)
      assert_not_nil search.size
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
  
  def test_chaining_page_size
    VCR.use_cassette('search chaining page size author') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).page_size!(30).author_is(@author)
      assert_not_nil search.size
      assert_not_nil search.facets
      assert((not search.facets.empty?))
      assert_not_nil search.records
      assert((not search.records.empty?))
      assert_equal 30, search.records.size
    end
  end

  def test_search_isbn
    VCR.use_cassette('search isbn') do
      search = Exlibris::Primo::Search.
        new(:base_url => @base_url, :institution => @institution)
      search.isbn_is @isbn
      assert_not_nil search.size
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
      search = Exlibris::Primo::Search.
        new(:base_url => @base_url, :institution => @institution, :record_id => @record_id)
      assert_not_nil search.size
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