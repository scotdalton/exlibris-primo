module WebService
  module Request
    require 'test_helper'
    class EshelfTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "University"
        @group = "Department"
      end

      def test_placeholder
        assert true
      end
    end
  end
end