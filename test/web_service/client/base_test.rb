module WebService
  module Client
    require 'test_helper'
    class BaseTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
      end

      def test_web_service_base_abstract_not_implemented
        VCR.use_cassette('web service base not implemented') do
          assert_raise(NotImplementedError) {
            web_service = Exlibris::Primo::WebService::Client::Base.new @base_url
          }
        end
      end

      def test_web_service_base_noexistent_method
        VCR.use_cassette('web service base crap method') do
          web_service = Exlibris::Primo::WebService::Client::Search.new @base_url
          assert_raise(NoMethodError) {
            web_service.crap_method
          }
        end
      end

      def test_web_service_base_no_arguments
        VCR.use_cassette('web service base no') do
          web_service = Exlibris::Primo::WebService::Client::Search.new @base_url
          assert_raise(ArgumentError, Savon::SOAP::Fault) {
            web_service.get_record
          }
        end
      end

      def test_web_service_base_too_many_arguments
        VCR.use_cassette('web service base too many') do
          web_service = Exlibris::Primo::WebService::Client::Search.new @base_url
          assert_raise(ArgumentError, Savon::SOAP::Fault) {
            web_service.get_record "1", "2"
          }
        end
      end
    end
  end
end