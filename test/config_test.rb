require 'test_helper'
class ConfigTest < Test::Unit::TestCase
  def test_config
    reset_primo_configuration
    Exlibris::Primo.configure do |config|
      config.base_url = "test_url"
      config.institution = "TEST_INSTITUTION"
      config.libraries = { "LIB_CODE1" => "Manually Library Decoded 1", "LIB_CODE2" => "Manually Library Decoded 2",
        "LIB_CODE3" => "Manually Library Decoded 3" }
    end
    assert_equal "test_url", Exlibris::Primo::Config.base_url
    assert_equal "TEST_INSTITUTION", Exlibris::Primo::Config.institution
    assert_equal({ "LIB_CODE1" => "Manually Library Decoded 1", "LIB_CODE2" => "Manually Library Decoded 2",
      "LIB_CODE3" => "Manually Library Decoded 3" }, Exlibris::Primo::Config.libraries)
    reset_primo_configuration
  end

  def test_config_from_yaml
    reset_primo_configuration
    yaml_primo_configuration
    assert_equal "yaml_url", Exlibris::Primo::Config.base_url
    assert_equal "YAML_INSTITUTION", Exlibris::Primo::Config.institution
    assert_nil(Exlibris::Primo::Config.institutions)
      assert_equal({ "LIB_CODE1" => "Library Decoded 1", "LIB_CODE2" => "Library Decoded 2",
        "LIB_CODE3" => "Library Decoded 3" }, Exlibris::Primo::Config.libraries)
    assert_equal({"processing"=>"In Processing",
      "offsite"=>"Available Offsite", "in_transit"=>"In Processing",
      "check_holdings"=>"Check Availability", "unavailable"=>"Unavailable",
      "available"=>"Available", "requested"=>"Requested", "billed_as_lost"=>"Billed as Lost",
      "request_ill"=>"Request ILL"}, Exlibris::Primo::Config.availability_statuses)
    assert_equal({
      "aleph"=> {"class_name"=>"Aleph", "base_url"=>"http://aleph.library.edu", "rest_url"=>"http://aleph.library.edu:1891/rest-dlf",
        "local_base"=>"LOCAL01", "requestable_statuses"=>["available"], "sub_library_codes"=> { 
          "LIB_CODE1"=>"AlephSubLibrary1", "LIB_CODE2"=>"AlephSubLibrary1", "LIB_CODE3"=>"AlephSubLibrary2"}},
      "source2"=> {"source_config2"=>"Some other source 2 config", "source_config1"=>"Some source 2 config"}, 
      "source1"=> {"source_config2"=>"Some other 1 source config", "source_config1"=>"Some source 1 config", 
        "class_name"=>"Source1ClassName"}}, Exlibris::Primo::Config.sources)
    assert_nil(Exlibris::Primo::Config.facet_labels)
    assert_nil(Exlibris::Primo::Config.facet_top_level)
    assert_nil(Exlibris::Primo::Config.facet_collections)
    assert_nil(Exlibris::Primo::Config.facet_resource_types)
    reset_primo_configuration
  end

  def test_config_attributes
    reset_primo_configuration
    yaml_primo_configuration
    search = Exlibris::Primo::Search.new
    assert_equal "yaml_url", search.base_url
    assert_equal "YAML_INSTITUTION", search.institution
    assert_equal({}, search.institutions)
    assert_equal({ "LIB_CODE1" => "Library Decoded 1", "LIB_CODE2" => "Library Decoded 2",
      "LIB_CODE3" => "Library Decoded 3" }, search.libraries)
    assert_equal({"processing"=>"In Processing",
      "offsite"=>"Available Offsite", "in_transit"=>"In Processing",
      "check_holdings"=>"Check Availability", "unavailable"=>"Unavailable",
      "available"=>"Available", "requested"=>"Requested", "billed_as_lost"=>"Billed as Lost",
      "request_ill"=>"Request ILL"}, search.availability_statuses)
    assert_equal({
      "aleph"=> {"class_name"=>"Aleph", "base_url"=>"http://aleph.library.edu", "rest_url"=>"http://aleph.library.edu:1891/rest-dlf",
        "local_base"=>"LOCAL01", "requestable_statuses"=>["available"], "sub_library_codes"=> { 
          "LIB_CODE1"=>"AlephSubLibrary1", "LIB_CODE2"=>"AlephSubLibrary1", "LIB_CODE3"=>"AlephSubLibrary2"}},
      "source2"=> {"source_config2"=>"Some other source 2 config", "source_config1"=>"Some source 2 config"}, 
      "source1"=> {"source_config2"=>"Some other 1 source config", "source_config1"=>"Some source 1 config", 
        "class_name"=>"Source1ClassName"}}, search.sources)
    assert_equal({}, search.facet_labels)
    assert_equal({}, search.facet_top_level)
    assert_equal({}, search.facet_collections)
    assert_equal({}, search.facet_resource_types)
    reset_primo_configuration
  end
end