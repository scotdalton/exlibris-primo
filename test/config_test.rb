require 'test_helper'
class ConfigTest < Test::Unit::TestCase
  def test_config
    Exlibris::Primo.configure do |config|
      # config.base_url = "test_url"
    end
    # assert_equal "test_url", Exlibris::Primo::Config.base_url
  end

  def test_config_from_yaml
    yaml_file = File.expand_path("../support/config.yml",  __FILE__)
    Exlibris::Primo.configure do |config|
      config.load_yaml yaml_file
    end
    assert_equal({ "LIB_CODE1" => "Library Decoded 1", "LIB_CODE2" => "Library Decoded 2",
      "LIB_CODE3" => "Library Decoded 3" }, Exlibris::Primo::Config.libraries)
  end
end