require 'test_helper'
class TagsTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @user_id = "N12162279"
    @institution = "NYU"
    @record_id = "nyu_aleph000062856"
  end

  def test_tags
    tags = Exlibris::Primo::Tags.new(:base_url => @base_url, 
      :institution => @institution, :user_id => @user_id, :record_id => @record_id)
    VCR.use_cassette('tags') do
      assert_not_nil tags.tags
      assert((not tags.tags.empty?))
    end
    VCR.use_cassette('tags user') do
      assert_not_nil tags.user_tags
      assert((not tags.user_tags.empty?))
    end
    VCR.use_cassette('tags record') do
      assert_not_nil tags.record_tags
      assert((not tags.record_tags.empty?))
    end
  end
end