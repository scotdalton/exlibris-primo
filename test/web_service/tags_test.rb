module WebService
  require 'test_helper'
  class TagsTest < Test::Unit::TestCase
    def setup
      @base = "http://bobcatdev.library.nyu.edu"
      @doc_id = "nyu_aleph000062856"
      @user_id = "N12162279"
      @institution = "NYU"
    end

    def test_tags
      VCR.use_cassette('web service get tags request') do
        tags_request = Exlibris::Primo::WebService::Request::GetTags.new
        tags_request.institution = @institution
        tags_request.user_id = @user_id
        tags_request.doc_id = @doc_id
        tags = Exlibris::Primo::WebService::Tags.new @base
        response = tags.get_tags tags_request
      end
    end
  end
end