require 'test_helper'
class RemoteRecordTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @institution = "NYU"
    @doc_id = "nyu_aleph000062856"
    @dedupmgr_id = "dedupmrg17343091"
  end

  def test_remote_record
    VCR.use_cassette('remote record call') do
      remote_record = Exlibris::Primo::RemoteRecord.new @base_url, @doc_id, {:institution => @institution}
      assert_equal "nyu_aleph000062856", remote_record.recordid
    end
  end

  def test_remote_record
    VCR.use_cassette('remote record dedupmgr') do
      remote_record = Exlibris::Primo::RemoteRecord.new @base_url, @dedupmgr_id, {:institution => @institution}
      assert_equal "dedupmrg17343091", remote_record.recordid
    end
  end
end