require 'test_helper'
class LinkTest < Test::Unit::TestCase
  def setup
    @record_id = "aleph002895625"
    @url = "http://example.com"
  end

  def test_new_base
    assert_raise(NotImplementedError) {
      Exlibris::Primo::Link.new
    }
  end

  def test_new_fulltext
    assert_nothing_raised {
      link = Exlibris::Primo::Fulltext.new :record_id => @record_id,
        :original_id => @record_id, :url => @url, :display => "Fulltext Instance"
      assert_equal "aleph002895625", link.record_id
      assert_equal "aleph002895625", link.original_id
      assert_equal "http://example.com", link.url
      assert_equal "Fulltext Instance", link.display
    }
  end

  def test_new_table_of_contents
    link = Exlibris::Primo::TableOfContents.new :record_id => @record_id,
      :original_id => @record_id, :url => @url, :display => "Table of Contents Instance"
    assert_equal "aleph002895625", link.record_id
    assert_equal "aleph002895625", link.original_id
    assert_equal "http://example.com", link.url
    assert_equal "Table of Contents Instance", link.display
  end

  def test_new_related_link
    link = Exlibris::Primo::RelatedLink.new :record_id => @record_id,
      :original_id => @record_id, :url => @url, :display => "Related Link Instance"
    assert_equal "aleph002895625", link.record_id
    assert_equal "aleph002895625", link.original_id
    assert_equal "http://example.com", link.url
    assert_equal "Related Link Instance", link.display
  end
end