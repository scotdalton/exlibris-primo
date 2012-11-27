module WebService
  module Client
    require 'test_helper'
    class AbstractTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @user_id = "N12162279"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
        @dedupmgr_id = "dedupmrg17343091"
      end

      def test_abstract_raise
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Client::Base.new
        }
      end

      def test_non_abstract_nothing_raised
        assert_nothing_raised {
          VCR.use_cassette('web service client eshelf wsdl') {
            Exlibris::Primo::WebService::Client::Eshelf.new :base_url => @base_url
          }
          VCR.use_cassette('web service client reviews wsdl') {
            Exlibris::Primo::WebService::Client::Reviews.new :base_url => @base_url
          }
          VCR.use_cassette('web service client search wsdl') {
            Exlibris::Primo::WebService::Client::Search.new :base_url => @base_url
          }
          VCR.use_cassette('web service client tags wsdl') {
            Exlibris::Primo::WebService::Client::Tags.new :base_url => @base_url
          }
        }
      end
    end
  end
end