module WebService
  module Response
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
          # 
          # The eshelf structure action is not specified in Primo's WSDL and 
          # is therefore not supported for the time being.
          # 
          # VCR.use_cassette('web service response eshelf structure') {
          #   Exlibris::Primo::WebService::Response::EshelfStructure.new(
          #     Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url).eshelf_structure(
          #       Exlibris::Primo::WebService::Request::EshelfStructure.new(:user_id => @user_id, 
          #         :institution => @institution).to_xml), 
          #     :eshelf_structure
          #   )
          # }
          VCR.use_cassette('web service response add folder to eshelf') {
            request = Exlibris::Primo::WebService::Request::AddFolderToEshelf.new
            Exlibris::Primo::WebService::Response::AddFolderToEshelf.new(
              Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url).add_folder_to_eshelf(request.to_xml), 
              :add_folder_to_eshelf
            )
          }
          VCR.use_cassette('web service response get eshelf') {
            request = Exlibris::Primo::WebService::Request::GetEshelf.new
            Exlibris::Primo::WebService::Response::GetEshelf.new(
              Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url).get_eshelf(request.to_xml), 
              :get_eshelf
            )
          }
          VCR.use_cassette('web service response add to eshelf') {
            request = Exlibris::Primo::WebService::Request::AddToEshelf.new
            Exlibris::Primo::WebService::Response::AddToEshelf.new(
              Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url).add_to_eshelf(request.to_xml), 
              :add_to_eshelf
            )
          }
          VCR.use_cassette('web service response remove from eshelf') {
            request = Exlibris::Primo::WebService::Request::RemoveFromEshelf.new
            Exlibris::Primo::WebService::Response::RemoveFromEshelf.new(
              Exlibris::Primo::WebService::Client::Eshelf.new(:base_url => @base_url).remove_from_eshelf(request.to_xml), 
              :remove_from_eshelf
            )
          }
          VCR.use_cassette('web service response get reviews') {
            request = Exlibris::Primo::WebService::Request::GetReviews.new
            Exlibris::Primo::WebService::Response::GetReviews.new(
              Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url).get_reviews(request.to_xml), 
              :get_reviews
            )
          }
          VCR.use_cassette('web service response get all my reviews') {
            request = Exlibris::Primo::WebService::Request::GetAllMyReviews.new
            Exlibris::Primo::WebService::Response::GetAllMyReviews.new(
              Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url).get_all_my_reviews(request.to_xml), 
              :get_all_my_reviews
            )
          }
          VCR.use_cassette('web service response get reviews for record') {
            request = Exlibris::Primo::WebService::Request::GetReviewsForRecord.new
            Exlibris::Primo::WebService::Response::GetReviewsForRecord.new(
              Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url).get_reviews_for_record(request.to_xml), 
              :get_reviews_for_record
            )
          }
          VCR.use_cassette('web service response get reviews by rating') {
            request = Exlibris::Primo::WebService::Request::GetReviewsByRating.new
            Exlibris::Primo::WebService::Response::GetReviewsByRating.new(
              Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url).get_reviews_by_rating(request.to_xml), 
              :get_reviews_by_rating
            )
          }
          VCR.use_cassette('web service response add review') {
            request = Exlibris::Primo::WebService::Request::AddReview.new
            Exlibris::Primo::WebService::Response::AddReview.new(
              Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url).add_review(request.to_xml), 
              :add_review
            )
          }
          VCR.use_cassette('web service response remove review') {
            request = Exlibris::Primo::WebService::Request::RemoveReview.new
            Exlibris::Primo::WebService::Response::RemoveReview.new(
              Exlibris::Primo::WebService::Client::Reviews.new(:base_url => @base_url).remove_review(request.to_xml), 
              :remove_review
            )
          }
          VCR.use_cassette('web service response get tags') {
            request = Exlibris::Primo::WebService::Request::GetTags.new
            Exlibris::Primo::WebService::Response::GetTags.new(
              Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url).get_tags(request.to_xml), 
              :get_tags
            )
          }
          VCR.use_cassette('web service response get all my tags') {
            request = Exlibris::Primo::WebService::Request::GetAllMyTags.new
            Exlibris::Primo::WebService::Response::GetAllMyTags.new(
              Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url).get_all_my_tags(request.to_xml), 
              :get_all_my_tags
            )
          }
          VCR.use_cassette('web service response get tags for record') {
            request = Exlibris::Primo::WebService::Request::GetTagsForRecord.new
            Exlibris::Primo::WebService::Response::GetTagsForRecord.new(
              Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url).get_tags_for_record(request.to_xml), 
              :get_tags_for_record
            )
          }
          VCR.use_cassette('web service response remove tag') {
            request = Exlibris::Primo::WebService::Request::RemoveTag.new
            Exlibris::Primo::WebService::Response::RemoveTag.new(
              Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url).remove_tag(request.to_xml), 
              :remove_tag
            )
          }
          VCR.use_cassette('web service response remove user tags') {
            request = Exlibris::Primo::WebService::Request::RemoveUserTags.new
            Exlibris::Primo::WebService::Response::RemoveUserTags.new(
              Exlibris::Primo::WebService::Client::Tags.new(:base_url => @base_url).remove_user_tags(request.to_xml), 
              :remove_user_tags
            )
          }
          VCR.use_cassette('web service response search') {
            request = Exlibris::Primo::WebService::Request::Search.new
            Exlibris::Primo::WebService::Response::Search.new(
              Exlibris::Primo::WebService::Client::Search.new(:base_url => @base_url).search_brief(request.to_xml), 
              :search_brief
            )
          }
          VCR.use_cassette('web service response full view') {
            request = Exlibris::Primo::WebService::Request::FullView.new
            Exlibris::Primo::WebService::Response::FullView.new(
              Exlibris::Primo::WebService::Client::Search.new(:base_url => @base_url).get_record(request.to_xml), 
              :get_record
            )
          }
        }
      end
    end
  end
end