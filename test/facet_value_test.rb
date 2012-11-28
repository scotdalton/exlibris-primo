require 'test_helper'
class FacetValueTest < Test::Unit::TestCase
  def test_new
    facet_value = Exlibris::Primo::FacetValue.new(:raw_xml => "<FACET_VALUES KEY=\"Greene, G\" VALUE=\"1\"/>")
    assert_equal "Greene, G", facet_value.name
    assert_equal 1, facet_value.count
  end
end