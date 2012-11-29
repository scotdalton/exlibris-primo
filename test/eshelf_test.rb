require 'test_helper'
class EshelfTest < Test::Unit::TestCase
  def setup
    @base_url = "http://bobcatdev.library.nyu.edu"
    @isbn = "0143039008"
    @user_id = "N12162279"
    @institution = "NYU"
  end

  def test_eshelf
    VCR.use_cassette('eshelf') do
      eshelf = Exlibris::Primo::EShelf.new(@user_id, :base_url => @base_url, :institution => @institution)
      assert_not_nil eshelf.records
      assert((not eshelf.records.empty?))
      assert_not_nil eshelf.count
      assert_not_nil eshelf.basket_id
      # eshelf.add_records(["PrimoRecordId","PrimoRecordId2"], basket_id)
    end
  end
end