module Pnx
  require 'test_helper'
  class OpenurlTest < Test::Unit::TestCase
    def test_openurl
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      assert_not_nil record.openurl
      assert((not record.openurl.blank?))
    end
  end
end