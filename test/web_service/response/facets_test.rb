module WebService
  module Response
    require 'test_helper'
    class FacetsTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "University"
        @group = "Department"
      end

      def test_new
        assert true
      end
    end
  end
end