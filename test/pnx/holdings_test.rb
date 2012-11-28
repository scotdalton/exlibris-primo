module Pnx
  require 'test_helper'
  class HoldingsTest < Test::Unit::TestCase
    def test_holdings
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      assert record.respond_to? :display_title
      assert record.respond_to? :recordid
      assert_not_nil record.holdings
      assert((not record.holdings.empty?))
    end
  end
end