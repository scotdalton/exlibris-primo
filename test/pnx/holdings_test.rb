module Pnx
  require 'test_helper'
  class HoldingsTest < Test::Unit::TestCase
    def test_load_other_holdings
      reset_primo_configuration
      record = Exlibris::Primo::Record.new(:raw_xml => record_other_source_xml)
      holdings = record.holdings.collect { | h | }
      assert record.respond_to? :display_title
      assert record.respond_to? :recordid
      assert_not_nil record.holdings
      holding = record.holdings.first
      assert_equal("nduspec_eadRBSC-MSNEA0506", holding.record_id)
      assert_nil(holding.original_source_id)
      assert_equal("RBSC-MSNEA0506", holding.source_record_id)
      assert_nil(holding.ils_api_id)
    end

    def test_holdings
      reset_primo_configuration
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      assert record.respond_to? :display_title
      assert record.respond_to? :recordid
      assert_not_nil record.holdings
      assert((not record.holdings.empty?))
      assert_equal(1, record.holdings.size)
      holding = record.holdings.first
      assert_equal("nyu_aleph000062856", holding.record_id)
      assert_equal("nyu_aleph000062856", holding.original_id)
      assert_equal("Travels with my aunt", holding.title)
      assert_equal("Graham  Greene  1904-1991.", holding.author)
      assert_equal("book", holding.display_type)
      assert_equal("nyu_aleph", holding.source_id)
      assert_equal("NYU01", holding.original_source_id)
      assert_equal("000062856", holding.source_record_id)
      assert_equal("NYU01000062856", holding.ils_api_id)
      assert_equal("NYU", holding.institution_code)
      assert_equal("BOBST", holding.library_code)
      assert_equal("unavailable", holding.availability_status_code)
      assert_equal("Main Collection", holding.collection)
      assert_equal("(PR6013.R44 T7 2004 )", holding.call_number)
      assert_equal([], holding.coverage)
      assert_equal("NYU", holding.institution)
      assert_equal("BOBST", holding.library)
      assert_equal("unavailable", holding.availability_status)
      assert_nil(holding.source_config)
      assert_nil(holding.source_class)
      assert_equal({}, holding.source_data)
      assert_equal(holding, holding.to_source)
      Exlibris::Primo.configure do |config|
        config.institutions = {"NYU" => "New York University"}
        config.libraries = {"BOBST" => "Elmer Holmes Bobst Library"}
        config.availability_statuses = {"unavailable" => "Not Available"}
      end
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      holding = record.holdings.first
      assert_equal("New York University", holding.institution)
      assert_equal("Elmer Holmes Bobst Library", holding.library)
      assert_equal("Not Available", holding.availability_status)
      reset_primo_configuration
      record = Exlibris::Primo::Record.new(:raw_xml => record_xml)
      holding = record.holdings.first
      assert_equal("NYU", holding.institution)
      assert_equal("BOBST", holding.library)
      assert_equal("unavailable", holding.availability_status)
    end
  end
end
