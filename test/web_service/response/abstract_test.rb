module WebService
  module Response
    require 'test_helper'
    class AbstractTest < Test::Unit::TestCase
      def setup
        @base_url = "http://bobcatdev.library.nyu.edu"
        @isbn = "0143039008"
        @user_id = "N12162279"
        @institution = "NYU"
        @doc_id = "nyu_aleph000062856"
        @dedupmgr_id = "dedupmrg17343091"
        @basket_id ="210075761"
        @new_folder_name = "new folder"
        @folder_to_remove = "377472735"
      end

      def test_abstract_raise
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Response::Base.new "", ""
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Response::Eshelf.new "", ""
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Response::Reviews.new "", ""
        }
        assert_raise(NotImplementedError) {
          Exlibris::Primo::WebService::Response::Tags.new "", ""
        }
      end

      def test_non_abstract_nothing_raised
        assert_nothing_raised {
          VCR.use_cassette('response get eshelf structure') {
            soap_action = :get_eshelf_structure
            request = Exlibris::Primo::WebService::Request::GetEshelfStructure.new(:user_id => @user_id, 
              :institution => @institution)
            client = Exlibris::Primo::WebService::Client::EshelfStructure.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetEshelfStructure.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get eshelf') {
            soap_action = :get_eshelf
            request = Exlibris::Primo::WebService::Request::GetEshelf.new(:user_id => @user_id, 
              :institution => @institution)
            client = Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetEshelf.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response add to eshelf') {
            soap_action = :add_to_eshelf
            request = Exlibris::Primo::WebService::Request::AddToEshelf.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id, :folder_id => @basket_id)
            client = Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::AddToEshelf.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response remove from eshelf') {
            soap_action = :remove_from_eshelf
            request = Exlibris::Primo::WebService::Request::RemoveFromEshelf.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id, :folder_id => @basket_id)
            client = Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::RemoveFromEshelf.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response add folder to eshelf') {
            soap_action = :add_folder_to_eshelf
            request = Exlibris::Primo::WebService::Request::AddFolderToEshelf.new(:user_id => @user_id, 
              :institution => @institution, :parent_folder => @basket_id, :folder_name => @new_folder_name)
            client = Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::AddFolderToEshelf.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response remove folder from eshelf') {
            soap_action = :remove_folder_from_eshelf
            request = Exlibris::Primo::WebService::Request::RemoveFolderFromEshelf.new(:user_id => @user_id, 
              :institution => @institution, :folder_id => @folder_to_remove)
            client = Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::RemoveFolderFromEshelf.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get reviews') {
            soap_action = :get_reviews
            request = Exlibris::Primo::WebService::Request::GetReviews.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id)
            client = Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetReviews.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get all my reviews') {
            soap_action = :get_all_my_reviews
            request = Exlibris::Primo::WebService::Request::GetAllMyReviews.new(:user_id => @user_id, 
              :institution => @institution)
            client = Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetAllMyReviews.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get reviews for record') {
            soap_action = :get_reviews_for_record
            request = Exlibris::Primo::WebService::Request::GetReviewsForRecord.new(
              :institution => @institution, :doc_id => @doc_id)
            client = Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetReviewsForRecord.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get reviews by rating') {
            soap_action = :get_reviews_by_rating
            request = Exlibris::Primo::WebService::Request::GetReviewsByRating.new(:user_id => @user_id, 
              :institution => @institution, :rating => "1")
            client = Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetReviewsByRating.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response add review') {
            soap_action = :add_review
            request = Exlibris::Primo::WebService::Request::AddReview.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id, :value => "Test reviews", :rating => "1", :user_display_name => "Test user display name", 
                :allow_user_name => "true", :status => "2")
            client = Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::AddReview.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response remove review') {
            soap_action = :remove_review
            request = Exlibris::Primo::WebService::Request::RemoveReview.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id)
            client = Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::RemoveReview.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get tags') {
            soap_action = :get_tags
            request = Exlibris::Primo::WebService::Request::GetTags.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id)
            client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetTags.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get all my tags') {
            soap_action = :get_all_my_tags
            request = Exlibris::Primo::WebService::Request::GetAllMyTags.new(:user_id => @user_id, 
              :institution => @institution)
            client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetAllMyTags.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response get tags for record') {
            soap_action = :get_tags_for_record
            request = Exlibris::Primo::WebService::Request::GetTagsForRecord.new(
              :institution => @institution, :doc_id => @doc_id)
            client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::GetTagsForRecord.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response add tag') {
            soap_action = :add_tag
            request = Exlibris::Primo::WebService::Request::AddTag.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id, :value => "test tag")
            client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::AddTag.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response remove tag') {
            soap_action = :remove_tag
            request = Exlibris::Primo::WebService::Request::RemoveTag.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id, :value => "test tag")
            client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::RemoveTag.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response remove user tags') {
            soap_action = :remove_user_tags
            request = Exlibris::Primo::WebService::Request::RemoveUserTags.new(:user_id => @user_id, 
              :institution => @institution)
            client = Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::RemoveUserTags.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response search') {
            soap_action = :search_brief
            request = Exlibris::Primo::WebService::Request::Search.new(:user_id => @user_id, 
              :institution => @institution)
            request.add_query_term(@isbn, "isbn", "exact")
            client = Exlibris::Primo::WebService::Client::Search.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::Search.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
          VCR.use_cassette('response full view') {
            soap_action = :get_record
            request = Exlibris::Primo::WebService::Request::FullView.new(:user_id => @user_id, 
              :institution => @institution, :doc_id => @doc_id)
            client = Exlibris::Primo::WebService::Client::Search.new(:base_url => @base_url)
            response =Exlibris::Primo::WebService::Response::FullView.new(
              client.send(soap_action, request.to_xml), soap_action)
          }
        }
      end
    end
  end
end