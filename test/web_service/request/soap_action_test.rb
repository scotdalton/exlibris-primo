module WebService
  module Request
    require 'test_helper'
    class ActionTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @isbn = "0143039008"
        @user_id = "N12162279"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
        @dedupmgr_id = "dedupmrg17343091"
        @basket_id ="210075761"
        @new_folder_name = "new folder"
        @folder_to_remove = "377473116"
      end

      def test_eshelf_soap_action
        assert_equal :get_eshelf_structure,
          Exlibris::Primo::WebService::Request::GetEshelfStructure.soap_action
        assert_equal :get_eshelf,
          Exlibris::Primo::WebService::Request::GetEshelf.soap_action
        assert_equal :add_to_eshelf,
          Exlibris::Primo::WebService::Request::AddToEshelf.soap_action
        assert_equal :remove_from_eshelf,
          Exlibris::Primo::WebService::Request::RemoveFromEshelf.soap_action
        assert_equal :add_folder_to_eshelf,
          Exlibris::Primo::WebService::Request::AddFolderToEshelf.soap_action
        assert_equal :remove_folder_from_eshelf,
          Exlibris::Primo::WebService::Request::RemoveFolderFromEshelf.soap_action
      end

      def test_call_eshelf_soap_action
        assert_nothing_raised {
          VCR.use_cassette('request get eshelf structure') do
            Exlibris::Primo::WebService::Request::GetEshelfStructure.new(:base_url => @base_url,
              :institution => @institution, :user_id => @user_id).call
          end
          VCR.use_cassette('request get eshelf') do
            Exlibris::Primo::WebService::Request::GetEshelf.new(:base_url => @base_url,
              :institution => @institution, :user_id => @user_id, :folder_id => @basket_id).call
          end
          VCR.use_cassette('request add to eshelf') do
            Exlibris::Primo::WebService::Request::AddToEshelf.new(:base_url => @base_url,
              :institution => @institution, :user_id => @user_id, :doc_id => @doc_id, :folder_id => @basket_id).call
          end
          VCR.use_cassette('request remove from eshelf') do
            Exlibris::Primo::WebService::Request::RemoveFromEshelf.new(:base_url => @base_url,
              :institution => @institution, :user_id => @user_id, :doc_id => @doc_id, :folder_id => @basket_id).call
          end
          VCR.use_cassette('request add folder to eshelf') do
            Exlibris::Primo::WebService::Request::AddFolderToEshelf.new(:base_url => @base_url,
              :institution => @institution, :user_id => @user_id, :folder_name => @new_folder_name, :parent_folder => @basket_id).call
          end
          VCR.use_cassette('request remove folder from eshelf') do
            Exlibris::Primo::WebService::Request::RemoveFolderFromEshelf.new(:base_url => @base_url,
              :institution => @institution, :user_id => @user_id, :folder_id => @folder_to_remove).call
          end
        }
      end

      def test_search_soap_action
        assert_equal :search_brief,
          Exlibris::Primo::WebService::Request::Search.soap_action
        assert_equal :get_record,
          Exlibris::Primo::WebService::Request::FullView.soap_action
      end

      def test_call_search_soap_action
        assert_nothing_raised {
          VCR.use_cassette('request search isbn') do
            request = Exlibris::Primo::WebService::Request::Search.new(:base_url => @base_url, :institution => @institution)
            request.add_query_term @isbn, "isbn", "exact"
            request.call
          end
          VCR.use_cassette('request full view') do
            Exlibris::Primo::WebService::Request::FullView.new(:base_url => @base_url, :doc_id => @doc_id).call
          end
        }
      end

      def test_reviews_soap_action
        assert_equal :get_reviews,
          Exlibris::Primo::WebService::Request::GetReviews.soap_action
        assert_equal :get_all_my_reviews,
          Exlibris::Primo::WebService::Request::GetAllMyReviews.soap_action
        assert_equal :get_reviews_for_record,
          Exlibris::Primo::WebService::Request::GetReviewsForRecord.soap_action
        assert_equal :get_reviews_by_rating,
          Exlibris::Primo::WebService::Request::GetReviewsByRating.soap_action
        assert_equal :add_review,
          Exlibris::Primo::WebService::Request::AddReview.soap_action
        assert_equal :remove_review,
          Exlibris::Primo::WebService::Request::RemoveReview.soap_action
      end

      def test_tags_soap_action
        assert_equal :get_tags,
          Exlibris::Primo::WebService::Request::GetTags.soap_action
        assert_equal :get_all_my_tags,
          Exlibris::Primo::WebService::Request::GetAllMyTags.soap_action
        assert_equal :get_tags_for_record,
          Exlibris::Primo::WebService::Request::GetTagsForRecord.soap_action
        assert_equal :remove_tag,
          Exlibris::Primo::WebService::Request::RemoveTag.soap_action
        assert_equal :remove_user_tags,
          Exlibris::Primo::WebService::Request::RemoveUserTags.soap_action
      end

      def test_undefined_action
        Exlibris::Primo::WebService::Request::Search.send(:soap_action=, :undefined_action)
        assert_raise(NoMethodError) {
          VCR.use_cassette('request undefined action call') do
            Exlibris::Primo::WebService::Request::Search.new(:base_url => @base_url).call
          end
        }
        Exlibris::Primo::WebService::Request::Search.send(:soap_action=, :search_brief)
      end
    end
  end
end