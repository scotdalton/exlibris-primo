module WebService
  module Request
    require 'test_helper'
    class BaseTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "University"
        @group = "Department"
      end
  
      def test_base_instantiation
        assert_raise(NotImplementedError) {
          request = Exlibris::Primo::WebService::Request::Base.new :base_url => @base_url
        }
      end

      def test_request_build_xml
          search_request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          inner_element = search_request.send :build_xml do |xml|
            xml.inner "value"
          end
          assert_kind_of String, inner_element
          assert_equal "<inner>value</inner>", inner_element
      end
    end
  end
end