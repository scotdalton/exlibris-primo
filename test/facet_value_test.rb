require 'test_helper'
class FacetValueTest < Test::Unit::TestCase
  def test_new
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"creator\" COUNT=\"3\" />")
    facet_value = Exlibris::Primo::FacetValue.new(:raw_xml => "<FACET_VALUES KEY=\"Greene, G\" VALUE=\"1\"/>", :facet => facet)
    assert_equal "Greene, G", facet_value.name
    assert_equal "Greene, G", facet_value.display_name
    assert_equal 1, facet_value.count
  end

  def test_facet_lang
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"lang\" COUNT=\"3\" />")
    facet_value = Exlibris::Primo::FacetValue.new(:raw_xml => "<FACET_VALUES KEY=\"en\" VALUE=\"1\"/>", :facet => facet)
    assert_equal "en", facet_value.name
    assert_equal "English", facet_value.display_name
    assert_equal 1, facet_value.count
  end

  def test_facet_library
    Exlibris::Primo.configure do |config|
      config.libraries = {"LIB" => "Library Display"}
    end
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"library\" COUNT=\"3\" />")
    facet_value = Exlibris::Primo::FacetValue.new(:raw_xml => "<FACET_VALUES KEY=\"LIB\" VALUE=\"1\"/>", :facet => facet)
    assert_equal "LIB", facet_value.name
    assert_equal "Library Display", facet_value.display_name
    assert_equal 1, facet_value.count
  end

  def test_facet_domain
    Exlibris::Primo.configure do |config|
      config.facet_collections = {"DOM" => "Library Domain"}
    end
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"domain\" COUNT=\"3\" />")
    facet_value = Exlibris::Primo::FacetValue.new(:raw_xml => "<FACET_VALUES KEY=\"DOM\" VALUE=\"1\"/>", :facet => facet)
    assert_equal "DOM", facet_value.name
    assert_equal "Library Domain", facet_value.display_name
    assert_equal 1, facet_value.count
  end

  def test_facet_top_level
    Exlibris::Primo.configure do |config|
      config.facet_top_level = {"available" => "Available Online"}
    end
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"tlevel\" COUNT=\"3\" />")
    facet_value = Exlibris::Primo::FacetValue.new(:raw_xml => "<FACET_VALUES KEY=\"available\" VALUE=\"1\"/>", :facet => facet)
    assert_equal "available", facet_value.name
    assert_equal "Available Online", facet_value.display_name
    assert_equal 1, facet_value.count
  end

  def test_facet_resource_type
    Exlibris::Primo.configure do |config|
      config.facet_resource_types = {"books" => "Manuscripts"}
    end
    facet = Exlibris::Primo::Facet.new(:raw_xml => "<FACET NAME=\"rtype\" COUNT=\"3\" />")
    facet_value = Exlibris::Primo::FacetValue.new(:raw_xml => "<FACET_VALUES KEY=\"books\" VALUE=\"1\"/>", :facet => facet)
    assert_equal "books", facet_value.name
    assert_equal "Manuscripts", facet_value.display_name
    assert_equal 1, facet_value.count
  end
end