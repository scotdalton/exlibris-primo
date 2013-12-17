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

    def test_invalid_frbr
      record = Exlibris::Primo::Record.new(:raw_xml => record_invalid_frbr_xml)
      assert_equal false,record.frbr?
      assert_nil record.frbr_id
      assert(record.frbr_id.blank?)
    end
  end
end