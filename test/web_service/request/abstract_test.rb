module WebService
  module Request
    require 'test_helper'
    class AbstractTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @user_id = "N12162279"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
        @dedupmgr_id = "dedupmrg17343091"
      end

      def test_abstract_raise
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::Base.new
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::User.new
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::Record.new
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::UserRecord.new
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::Eshelf.new
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::EshelfRecord.new
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::Reviews.new
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Request::Tags.new
        }
      end

      def test_non_abstract_nothing_raised
        assert_nothing_raised {
          # 
          # The eshelf structure action is not specified in Primo's WSDL and 
          # is therefore not supported for the time being.
          # 
          # Exlibris::Primo::WebService::Request::EshelfStructure.new
          Exlibris::Primo::WebService::Request::AddFolderToEshelf.new
          Exlibris::Primo::WebService::Request::GetEshelf.new
          Exlibris::Primo::WebService::Request::AddToEshelf.new
          Exlibris::Primo::WebService::Request::RemoveFromEshelf.new
          Exlibris::Primo::WebService::Request::GetReviews.new
          Exlibris::Primo::WebService::Request::GetAllMyReviews.new
          Exlibris::Primo::WebService::Request::GetReviewsForRecord.new
          Exlibris::Primo::WebService::Request::GetReviewsByRating.new
          Exlibris::Primo::WebService::Request::AddReview.new
          Exlibris::Primo::WebService::Request::RemoveReview.new
          Exlibris::Primo::WebService::Request::GetTags.new
          Exlibris::Primo::WebService::Request::GetAllMyTags.new
          Exlibris::Primo::WebService::Request::GetTagsForRecord.new
          Exlibris::Primo::WebService::Request::RemoveTag.new
          Exlibris::Primo::WebService::Request::RemoveUserTags.new
          Exlibris::Primo::WebService::Request::Search.new
          Exlibris::Primo::WebService::Request::FullView.new
        }
      end
    end
  end
end