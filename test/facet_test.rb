require 'test_helper'
class FacetTest < Test::Unit::TestCase
  def test_new
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"creator\" COUNT=\"3\">"+
      "<FACET_VALUES KEY=\"Author1, FirstName\" VALUE=\"3\"/>"+
      "<FACET_VALUES KEY=\"Author2, FirstName\" VALUE=\"1\"/>"+
      "</FACET>")
    assert_equal "creator", facet.name
    assert_equal 3, facet.size
    assert_equal 2, facet.facet_values.size
  end
end