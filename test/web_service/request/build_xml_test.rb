module WebService
  module Request
    require 'test_helper'
    class BuildXmlTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "University"
        @group = "Department"
      end
  
      def test_request_build_xml
          search_request = Exlibris::Primo::WebService::Request::Search.new :base_url => @base_url
          element = search_request.send :build_xml do |xml|
            xml.outer {
              xml.inner "value"
            }
          end
          assert_kind_of String, element
          assert_equal "<outer><inner>value</inner></outer>", element
      end
    end
  end
end