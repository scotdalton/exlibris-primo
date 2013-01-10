require 'test_helper'
class EshelfTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @isbn = "0143039008"
    @user_id = "N12162279"
    @institution = "NYU"
    @eshelf_records = ["nyu_aleph000980206", "nyu_aleph000864162", "dedupmrg35761381"]
    @eshelf_record = "nyu_aleph003531438"
    @folder_name = "New Folder Eshelf"
  end

  def test_eshelf
    eshelf = Exlibris::Primo::EShelf.new(:user_id => @user_id, 
      :base_url => @base_url, :institution => @institution)
    basket_id = ""
    size = 0
    VCR.use_cassette('eshelf records') do
      assert_not_nil eshelf.records
      assert((not eshelf.records.empty?))
      assert_not_nil eshelf.size
      size = eshelf.size
    end
    VCR.use_cassette('eshelf basket id') do
      basket_id = eshelf.basket_id
      assert_not_nil basket_id
    end
    VCR.use_cassette('eshelf add records') do
      eshelf.add_records(@eshelf_records, basket_id)
      assert_not_nil eshelf.records
      assert((not eshelf.records.empty?))
      assert_not_nil eshelf.size
      assert_equal(size+3, eshelf.size)
    end
    VCR.use_cassette('eshelf add record') do
      eshelf.add_record(@eshelf_record, basket_id)
      assert_not_nil eshelf.records
      assert((not eshelf.records.empty?))
      assert_not_nil eshelf.size
      assert_equal(size+4, eshelf.size)
    end
    VCR.use_cassette('eshelf remove records') do
      eshelf.remove_records(@eshelf_records, basket_id)
      assert_not_nil eshelf.records
      assert_not_nil eshelf.size
      assert_equal(size+1, eshelf.size)
    end
    VCR.use_cassette('eshelf remove record') do
      eshelf.remove_record(@eshelf_record, basket_id)
      assert_not_nil eshelf.records
      assert_not_nil eshelf.size
      assert_equal(size, eshelf.size)
    end
    VCR.use_cassette('eshelf add folder') do
      assert_nil eshelf.folder_id(@folder_name)
      eshelf.add_folder(@folder_name, basket_id)
      assert_not_nil eshelf.folder_id(@folder_name)
    end
    VCR.use_cassette('eshelf remove folder') do
      assert_not_nil eshelf.folder_id(@folder_name)
      folder_id = eshelf.folder_id(@folder_name)
      eshelf.remove_folder(folder_id)
      assert_nil eshelf.folder_id(@folder_name)
    end
  end
end