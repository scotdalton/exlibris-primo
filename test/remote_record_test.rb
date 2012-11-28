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
      remote_record = Exlibris::Primo::RemoteRecord.new @doc_id, {:base_url => @base_url, :institution => @institution}
      assert_equal "nyu_aleph000062856", remote_record.recordid
    end
  end

  def test_remote_record_dedup
    VCR.use_cassette('remote record dedupmgr') do
      remote_record = Exlibris::Primo::RemoteRecord.new @dedupmgr_id, {:base_url => @base_url, :institution => @institution}
      assert_equal "dedupmrg17343091", remote_record.recordid
    end
  end
  
  def test_record_method
    VCR.use_cassette('remote record dedupmgr') do
      remote_record = Exlibris::Primo::RemoteRecord.new @dedupmgr_id, {:base_url => @base_url, :institution => @institution}
      assert(remote_record.respond_to? :to_xml)
      assert_nothing_raised {
        assert_not_nil remote_record.to_xml
      }
    end
  end
end