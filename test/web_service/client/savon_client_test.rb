module WebService
  module Client
    require 'test_helper'
    class SavonClientTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
      end

      def test_nonexistent_soap_action
        VCR.use_cassette('client nonexistent soap action') do
          client = Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
          assert_kind_of Savon::Client, client.send(:client)
        end
      end
    end
  end
end