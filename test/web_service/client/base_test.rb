require 'test_helper'
class WebServiceBaseTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
  end

  def test_web_service_base_abstract_not_implemented
    VCR.use_cassette('web service base') do
      assert_raise(NotImplementedError) {
        web_service = Exlibris::Primo::WebService::Client::Base.new @base_url
      }
    end
  end

  def test_web_service_base_noexistent_method
    VCR.use_cassette('web service base') do
      web_service = Exlibris::Primo::WebService::Client::Search.new @base_url
      assert_raise(NoMethodError) {
        web_service.crap_method
      }
    end
  end

  def test_web_service_base_no_arguments
    VCR.use_cassette('web service base') do
      web_service = Exlibris::Primo::WebService::Client::Search.new @base_url
      assert_raise(ArgumentError) {
        web_service.get_record
      }
    end
  end

  def test_web_service_base_too_name_arguments
    VCR.use_cassette('web service base') do
      web_service = Exlibris::Primo::WebService::Client::Search.new @base_url
      assert_raise(ArgumentError) {
        web_service.get_record "1", "2"
      }
    end
  end
end