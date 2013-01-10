module Pnx
  require 'test_helper'
  class FrbrTest < Test::Unit::TestCase
    def test_frbr
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      assert record.frbr?
      assert_not_nil record.frbr_id
      assert((not record.frbr_id.blank?))
      assert_equal "49340863", record.frbr_id
    end
  end
end