require 'test_helper'
class TagsTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @user_id = "N12162279"
    @institution = "NYU"
    @record_id = "nyu_aleph000062856"
  end

  def test_tags
    VCR.use_cassette('tags') do
      tags = Exlibris::Primo::Tags.new(:base_url => @base_url, :institution => @institution, :user_id => @user_id, :record_id => @record_id)
      assert_not_nil tags.my_tags
      assert((not tags.my_tags.empty?))
      assert_not_nil tags.everybody_tags
      assert((not tags.everybody_tags.empty?))
    end
  end
end