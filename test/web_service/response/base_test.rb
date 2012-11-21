module WebService
  module Response
    require 'test_helper'
    class BaseTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "University"
        @group = "Department"
      end
  
      def test_base_instantiation
        assert_raise(NotImplementedError) {
          request = Exlibris::Primo::WebService::Response::Base.new "", ""
        }
      end
    end
  end
end