require 'test_helper'
class ConfigTest < Test::Unit::TestCase
  def test_config
    Exlibris::Primo.configure do |config|
      config.base_url = "test_url"
      config.institution = "TEST_INSTITUTION"
      config.libraries = { "LIB_CODE1" => "Manually Library Decoded 1", "LIB_CODE2" => "Manually Library Decoded 2",
        "LIB_CODE3" => "Manually Library Decoded 3" }
    end
    assert_equal "test_url", Exlibris::Primo::Config.base_url
    assert_equal "TEST_INSTITUTION", Exlibris::Primo::Config.institution
    assert_equal({ "LIB_CODE1" => "Manually Library Decoded 1", "LIB_CODE2" => "Manually Library Decoded 2",
      "LIB_CODE3" => "Manually Library Decoded 3" }, Exlibris::Primo::Config.libraries)  end

  def test_config_from_yaml
    yaml_file = File.expand_path("../support/config.yml",  __FILE__)
    Exlibris::Primo.configure do |config|
      config.load_yaml yaml_file
    end
    assert_equal "yaml_url", Exlibris::Primo::Config.base_url
    assert_equal "YAML_INSTITUTION", Exlibris::Primo::Config.institution
    assert_equal({ "LIB_CODE1" => "Library Decoded 1", "LIB_CODE2" => "Library Decoded 2",
      "LIB_CODE3" => "Library Decoded 3" }, Exlibris::Primo::Config.libraries)
    assert_equal({"processing"=>"In Processing",
      "offsite"=>"Available Offsite", "in_transit"=>"In Processing",
      "check_holdings"=>"Check Availability", "unavailable"=>"Unavailable",
      "available"=>"Available", "requested"=>"Requested", "billed_as_lost"=>"Billed as Lost",
      "request_ill"=>"Request ILL"}, Exlibris::Primo::Config.availability_statuses)
    assert_equal({"source2"=> {"source_config2"=>"Some other source 2 config",
      "source_config1"=>"Some source 2 config"}, "source1"=> {"source_config2"=>"Some other 1 source config",
      "source_config1"=>"Some source 1 config", "class_name"=>"Source1ClassName"}}, Exlibris::Primo::Config.sources)
  end
end