module WebService
  require 'test_helper'
  class EshelfTest < Test::Unit::TestCase
    def setup
      @base = "http://bobcatdev.library.nyu.edu"
      @doc_id = "nyu_aleph000062856"
      @user_id = "N12162279"
      @institution = "NYU"
    end

    def test_eshelf
      VCR.use_cassette('web service get eshelf request') do
        eshelf_request = Exlibris::Primo::WebService::Request::GetEshelf.new
        eshelf_request.institution = @institution
        eshelf_request.user_id = @user_id
        eshelf = Exlibris::Primo::WebService::Eshelf.new @base
        response = eshelf.get_eshelf eshelf_request
      end
    end
  end
end