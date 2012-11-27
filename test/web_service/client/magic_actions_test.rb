module WebService
  module Client
    require 'test_helper'
    class MagicActionsTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
      end

      def test_nonexistent_action
        VCR.use_cassette('client nonexistent method') do
          client = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
          assert_raise(NoMethodError) {
            client.nonexistent_action
          }
        end
      end

      def test_no_arguments
        VCR.use_cassette('client action no arguments') do
          client = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
          assert_raise(ArgumentError, Savon::SOAP::Fault) {
            client.get_record
          }
        end
      end

      def test_too_many_arguments
        VCR.use_cassette('client too many arguments') do
          client = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
          assert_raise(ArgumentError, Savon::SOAP::Fault) {
            client.get_record "1", "2"
          }
        end
      end
    end
  end
end