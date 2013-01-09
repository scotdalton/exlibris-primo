require 'test_helper'
class TagsTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @user_id = "N12162279"
    @institution = "NYU"
    @record_id = "nyu_aleph000062856"
    @tags = ["tag1", "tag2", "tag 3"]
    @tag = "tag4"
    @extra_tag = "tag 5"
  end

  def test_tags
    tags = Exlibris::Primo::Tags.new(:base_url => @base_url, 
      :institution => @institution, :user_id => @user_id, :record_id => @record_id)
    VCR.use_cassette('tags check empty tags first') do
      assert_not_nil tags.tags
      assert(tags.tags.empty?)
    end
    VCR.use_cassette('tags add tags') do
      tags.add_tags @tags
    end
    VCR.use_cassette('tags add tag') do
      tags.add_tag @tag
    end
    VCR.use_cassette('tags add extra tag') do
      tags.add_tag @extra_tag
    end
    VCR.use_cassette('tags tags') do
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
    VCR.use_cassette('tags remove tags') do
      tags.remove_tags @tags
    end
    VCR.use_cassette('tags check 2 tags') do
      assert_not_nil tags.tags
      assert((not tags.tags.empty?))
      assert_equal(2, tags.tags.size)
    end
    VCR.use_cassette('tags remove tag') do
      tags.remove_tag @tag
    end
    VCR.use_cassette('tags check 1 tags') do
      assert_not_nil tags.tags
      assert((not tags.tags.empty?))
      assert_equal(1, tags.tags.size)
    end
    VCR.use_cassette('tags remove user tags') do
      tags.remove_user_tags
    end
    VCR.use_cassette('tags check empty tags last') do
      assert_not_nil tags.tags
      assert(tags.tags.empty?)
    end
  end
end