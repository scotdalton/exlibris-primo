module WebService
  module Request
    require 'test_helper'
    class ActionTest < Test::Unit::TestCase
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

      def test_eshelf_base_elements
        assert_equal :get_eshelf_structure,
          Exlibris::Primo::WebService::Request::GetEshelfStructure.soap_action
        assert_equal :add_folder_to_eshelf,
          Exlibris::Primo::WebService::Request::AddFolderToEshelf.soap_action
        assert_equal :get_eshelf,
          Exlibris::Primo::WebService::Request::GetEshelf.soap_action
        assert_equal :add_to_eshelf,
          Exlibris::Primo::WebService::Request::AddToEshelf.soap_action
        assert_equal :remove_from_eshelf,
          Exlibris::Primo::WebService::Request::RemoveFromEshelf.soap_action
      end
      
      def test_new_eshelf_base_elements
        assert_nothing_raised {
          # 
          # The eshelf structure action is not specified in Primo's WSDL and 
          # is therefore not supported for the time being.
          # 
          # Exlibris::Primo::WebService::Request::EshelfStructure.new(:base_url => @base_url).call
          VCR.use_cassette('request action add folder to eshelf call') do
            Exlibris::Primo::WebService::Request::AddFolderToEshelf.new(:base_url => @base_url).call
          end
          VCR.use_cassette('request action get eshelf call') do
            Exlibris::Primo::WebService::Request::GetEshelf.new(:base_url => @base_url).call
          end
          VCR.use_cassette('request action add to eshelf call') do
            Exlibris::Primo::WebService::Request::AddToEshelf.new(:base_url => @base_url).call
          end
          VCR.use_cassette('request action remove eshelf call') do
            Exlibris::Primo::WebService::Request::RemoveFromEshelf.new(:base_url => @base_url).call
          end
        }
      end

      def test_search_base_elements
        assert_equal :search_brief,
          Exlibris::Primo::WebService::Request::Search.soap_action
        assert_equal :get_record,
          Exlibris::Primo::WebService::Request::FullView.soap_action
      end
      
      def test_new_search_base_elements
        assert_nothing_raised {
          VCR.use_cassette('request action search call') do
            Exlibris::Primo::WebService::Request::Search.new(:base_url => @base_url).call
          end
          VCR.use_cassette('request action full view call') do
            Exlibris::Primo::WebService::Request::FullView.new(:base_url => @base_url).call
          end
        }
      end

      def test_reviews_base_elements
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

      def test_tags_base_elements
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