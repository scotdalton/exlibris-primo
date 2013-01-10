require 'test_helper'
class FacetTest < Test::Unit::TestCase
  def test_new
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"creator\" COUNT=\"3\">"+
      "<FACET_VALUES KEY=\"Author1, FirstName\" VALUE=\"3\"/>"+
      "<FACET_VALUES KEY=\"Author2, FirstName\" VALUE=\"1\"/>"+
      "</FACET>")
    assert_equal "creator", facet.name
    assert_equal "creator", facet.display_name
    assert_equal 3, facet.size
    assert_equal 2, facet.facet_values.size
  end

  def test_facet_label
    Exlibris::Primo.configure do |config|
      config.facet_labels = {"lcc" => "LC Subject Headings"}
    end
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"lcc\" COUNT=\"3\">"+
      "<FACET_VALUES KEY=\"A. Some Value\" VALUE=\"3\"/>"+
      "<FACET_VALUES KEY=\"B. Some Other Value\" VALUE=\"1\"/>"+
      "</FACET>")
    assert_equal "lcc", facet.name
    assert_equal "LC Subject Headings", facet.display_name
    assert_equal 3, facet.size
    assert_equal 2, facet.facet_values.size
  end
end