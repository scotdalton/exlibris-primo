module WebService
  module Request
    require 'test_helper'
    class ClientTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @institution = "University"
        @ip = "127.0.0.1"
        @group = "Department"
        @on_campus = "true"
        @is_logged_in = "true"
        @pds_handle = "pds_handle_dummy"
        @user_id = "user_id_dummy"
        @folder_id = "folder_id_dummy"
        @doc_id = "doc_id_dummy"
        @folder_name = "new folder, dummy"
        @parent_folder = "parent_folder_dummy"
        @search_key = "search_key_dummy"
      end

      def test_eshelf_client
        assert_equal :eshelf_structure, Exlibris::Primo::WebService::Request::GetEshelfStructure.client
        assert_equal :eshelf, Exlibris::Primo::WebService::Request::AddFolderToEshelf.client
        assert_equal :eshelf, Exlibris::Primo::WebService::Request::GetEshelf.client
        assert_equal :eshelf, Exlibris::Primo::WebService::Request::AddToEshelf.client
        assert_equal :eshelf, Exlibris::Primo::WebService::Request::RemoveFromEshelf.client
        assert_equal :eshelf, Exlibris::Primo::WebService::Request::GetEshelf.client
      end

      def test_search_client
        assert_equal :search, Exlibris::Primo::WebService::Request::Search.client
        assert_equal :search, Exlibris::Primo::WebService::Request::FullView.client
      end
      
      def test_reviews_client
        assert_equal :reviews, Exlibris::Primo::WebService::Request::GetReviews.client
        assert_equal :reviews, Exlibris::Primo::WebService::Request::GetAllMyReviews.client
        assert_equal :reviews, Exlibris::Primo::WebService::Request::GetReviewsForRecord.client
        assert_equal :reviews, Exlibris::Primo::WebService::Request::GetReviewsByRating.client
        assert_equal :reviews, Exlibris::Primo::WebService::Request::AddReview.client
        assert_equal :reviews, Exlibris::Primo::WebService::Request::RemoveReview.client
      end

      def test_tags_client
        assert_equal :tags, Exlibris::Primo::WebService::Request::GetTags.client
        assert_equal :tags, Exlibris::Primo::WebService::Request::GetAllMyTags.client
        assert_equal :tags, Exlibris::Primo::WebService::Request::GetTagsForRecord.client
        assert_equal :tags, Exlibris::Primo::WebService::Request::RemoveTag.client
        assert_equal :tags, Exlibris::Primo::WebService::Request::RemoveUserTags.client
      end
    end
  end
end