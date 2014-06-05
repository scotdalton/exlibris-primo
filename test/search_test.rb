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

  def test_chaining_isbn
    VCR.use_cassette('search chaining isbn') do
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

  def test_title_with_ampersand
    VCR.use_cassette('search title with ampersand') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).title_is("wallace & gromit")
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

  def test_chaining_contains_any
    VCR.use_cassette('search chaining contains any') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).any_contains("digital divide")
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

  def test_locations
    VCR.use_cassette('search locations') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).any_contains("digital divide").add_local_location("scope:(NYU)")
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

  def test_sort_by_locations
    VCR.use_cassette('search sort by locations') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).any_contains("digital divide").
          add_sort_by("stitle").add_local_location("scope:(NYU)")
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
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).record_id!(@record_id)
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

  def test_search_enable_highlighting
    VCR.use_cassette('search enable highlighting') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).title_contains("digital divide").
          enable_highlighting.add_display_field("title")
      assert_not_nil search.size
      assert_not_nil search.facets
      assert((not search.facets.empty?))
      assert_not_nil search.records
      assert((not search.records.empty?))
      search.records.each do |record|
        assert_match(/<span class="searchword">/, record.display_title)
      end
    end
  end

  def test_search_sort_by
    VCR.use_cassette('search sort by') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).title_contains("digital divide").
          add_sort_by("stitle")
      assert_not_nil search.size
      assert_not_nil search.facets
      assert((not search.facets.empty?))
      assert_not_nil search.records
      assert((not search.records.empty?))
      sorted_titles = []
      search.records.each do |record|
        sorted_titles<< record.display_title
      end
      sorted_titles.sort.each_index {|index|
        assert(sorted_titles[index].eql?(sorted_titles.sort[index]), "Sort failed.")}
    end
  end

  def test_search_languages
    VCR.use_cassette('search languages') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).title_contains("digital divide").
          add_language("en")
      assert_not_nil search.size
      assert_not_nil search.facets
      assert((not search.facets.empty?))
      assert_not_nil search.records
      assert((not search.records.empty?))
    end
  end

  def test_search_record_id_chaining
    VCR.use_cassette('search record id chaining') do
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

  def test_chaining
    search = Exlibris::Primo::Search.new
    assert_kind_of Exlibris::Primo::Search, search.base_url!(@base_url)
    assert_kind_of Exlibris::Primo::Search, search.institution!(@institution)
    assert_kind_of Exlibris::Primo::Search, search.ip!("127.0.0.1")
    assert_kind_of Exlibris::Primo::Search, search.group!("Deparment")
    assert_kind_of Exlibris::Primo::Search, search.pds_handle!("PDS_HANDLE_TEST")
    assert_kind_of Exlibris::Primo::Search, search.on_campus
    assert_kind_of Exlibris::Primo::Search, search.off_campus
    assert_kind_of Exlibris::Primo::Search, search.logged_in
    assert_kind_of Exlibris::Primo::Search, search.logged_out
    assert_kind_of Exlibris::Primo::Search, search.logged_off
    assert_kind_of Exlibris::Primo::Search, search.or
    assert_kind_of Exlibris::Primo::Search, search.and
    assert_kind_of Exlibris::Primo::Search, search.start_index!(1)
    assert_kind_of Exlibris::Primo::Search, search.page_size!(20)
    assert_kind_of Exlibris::Primo::Search, search.enable_did_u_mean
    assert_kind_of Exlibris::Primo::Search, search.disable_did_u_mean
    assert_kind_of Exlibris::Primo::Search, search.enable_highlighting
    assert_kind_of Exlibris::Primo::Search, search.disable_highlighting
    assert_kind_of Exlibris::Primo::Search, search.add_language("en")
    assert_kind_of Exlibris::Primo::Search, search.add_sort_by("stitle")
    assert_kind_of Exlibris::Primo::Search, search.add_display_field("title")
    assert_kind_of Exlibris::Primo::Search, search.add_local_location("scope:(VOLCANO)")
    assert_kind_of Exlibris::Primo::Search, search.add_remote_location("quickset_name")
    assert_kind_of Exlibris::Primo::Search, search.add_adaptor_location("primo_central_multiple_fe")
    assert_kind_of Exlibris::Primo::Search, search.record_id!(@record_id)
    assert_equal search.send(:search_request).boolean_operator, "AND"
  end

  def test_existent_search_methods
    search = Exlibris::Primo::Search.new
    assert(search.respond_to? :author_is)
    assert_nothing_raised {
      search.author_is("test")
    }
    assert(search.respond_to? :title_is)
    assert_nothing_raised {
      search.title_is("test")
    }
  end

  def test_nonexistent_search_methods
    search = Exlibris::Primo::Search.new
    assert((not search.respond_to? :google_is))
    assert_raise(NoMethodError) {
      search.google_is
    }
    assert((not search.respond_to? :author_wants))
    assert_raise(NoMethodError) {
      search.author_wants
    }
    assert((not search.respond_to? :no_match))
    assert_raise(NoMethodError) {
      search.no_match
    }
  end

  def test_and_or_methods
    assert_nothing_raised {
      search = Exlibris::Primo::Search.new
      assert search.class.public_instance_methods.collect{|m|m.to_sym}.include? :and
      assert search.class.public_instance_methods.collect{|m|m.to_sym}.include? :or
      assert_equal "AND", search.send(:search_request).boolean_operator
      assert_equal "OR", search.or.send(:search_request).boolean_operator
      assert_equal "AND", search.and.send(:search_request).boolean_operator
    }
  end

  def test_did_u_mean
    VCR.use_cassette('search did u mean') do
      search = Exlibris::Primo::Search.new.base_url!(@base_url).
        institution!(@institution).title_contains("digital dvide").enable_did_u_mean
      assert_not_nil search.size
      assert_equal 0, search.size
      assert_not_nil search.did_u_mean
      assert_equal "digital video", search.did_u_mean
    end
  end
end
