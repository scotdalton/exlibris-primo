require 'test_helper'
class HoldingTest < Test::Unit::TestCase
  def setup
    @record_id = "aleph002895625"
  end

  def test_new_holding
    holding = Exlibris::Primo::Holding.new :record_id => @record_id,
      :original_id => @record_id, :title => "Holding Title", :author => "Holding Author", 
      :display_type => "Book"
    assert_equal "aleph002895625", holding.record_id
    assert_equal "aleph002895625", holding.original_id
    assert_equal "Holding Title", holding.title
    assert_equal "Holding Author", holding.author
    assert_equal "Book", holding.display_type
    assert_equal([], holding.coverage)
    assert_nil(holding.source_config)
    assert_nil(holding.source_class)
    assert_equal({}, holding.source_data)
    assert_equal(holding, holding.to_source)
    assert_equal([holding], holding.expand)
    assert((not holding.eql?(Exlibris::Primo::Holding.new)))
    assert(holding.eql?(holding))
    assert_equal(holding, holding.merge!(holding))
    assert(holding.expand.include?(holding))
  end
end