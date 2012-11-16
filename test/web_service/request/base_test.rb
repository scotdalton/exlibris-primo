module WebService
  module Request
    require 'test_helper'
    class BaseTest < Test::Unit::TestCase
      def setup
        @institution = "University"
        @group = "Department"
      end
  
      def test_search_search_request
        assert_raise(NotImplementedError) {
          request = Exlibris::Primo::WebService::Request::Base.new :test_request
        }
      end
    end
  end
end