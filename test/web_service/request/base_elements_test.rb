module WebService
  module Request
    require 'test_helper'
    class BaseElementsTest < Test::Unit::TestCase
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

      def test_base_base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle],
          Exlibris::Primo::WebService::Request::Base.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id],
          Exlibris::Primo::WebService::Request::UserBase.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id],
          Exlibris::Primo::WebService::Request::Record.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id],
          Exlibris::Primo::WebService::Request::UserRecord.base_elements
      end

      def test_eshelf_base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :folder_id],
          Exlibris::Primo::WebService::Request::Eshelf.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :folder_id, :doc_id],
          Exlibris::Primo::WebService::Request::EshelfRecord.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :folder_id, :include_basket_items],
          Exlibris::Primo::WebService::Request::GetEshelfStructure.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :folder_name, :parent_folder],
          Exlibris::Primo::WebService::Request::AddFolderToEshelf.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :folder_id, :get_delivery],
          Exlibris::Primo::WebService::Request::GetEshelf.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :doc_id, :searchkey],
          Exlibris::Primo::WebService::Request::AddToEshelf.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :folder_id, :doc_id],
          Exlibris::Primo::WebService::Request::RemoveFromEshelf.base_elements
      end
      
      def test_new_eshelf_base_elements
        # 
        # The eshelf structure action is not specified in Primo's WSDL and 
        # is therefore not supported for the time being.
        # 
        # assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :folder_id, :include_basket_items],
        #   Exlibris::Primo::WebService::Request::GetEshelfStructure.base_elements
        assert_nothing_raised {
          request = Exlibris::Primo::WebService::Request::AddFolderToEshelf.new(
            :institution => @institution, 
            :ip => @ip, 
            :group => @group, 
            :on_campus => @on_campus, 
            :is_logged_in => @is_logged_in, 
            :pds_handle => @pds_handle, 
            :user_id => @user_id, 
            :folder_name => @folder_name, 
            :parent_folder => @parent_folder
          )
          assert_equal "<institution>University</institution>"+
            "<ip>127.0.0.1</ip>"+
            "<group>Department</group>"+
            "<onCampus>true</onCampus>"+
            "<isLoggedIn>true</isLoggedIn>"+
            "<pdsHandle>pds_handle_dummy</pdsHandle>"+
            "<userId>user_id_dummy</userId>"+
            "<folderName>new folder, dummy</folderName>"+
            "<parentFolder>parent_folder_dummy</parentFolder>", request.send(:base_elements_xml)
        }
        assert_nothing_raised {
          request = Exlibris::Primo::WebService::Request::GetEshelf.new(
            :institution => @institution, 
            :ip => @ip, 
            :group => @group, 
            :on_campus => @on_campus, 
            :is_logged_in => @is_logged_in, 
            :pds_handle => @pds_handle, 
            :user_id => @user_id, 
            :folder_id => @folder_id
          )
          assert_equal "<institution>University</institution>"+
            "<ip>127.0.0.1</ip>"+
            "<group>Department</group>"+
            "<onCampus>true</onCampus>"+
            "<isLoggedIn>true</isLoggedIn>"+
            "<pdsHandle>pds_handle_dummy</pdsHandle>"+
            "<userId>user_id_dummy</userId>"+
            "<folderId>folder_id_dummy</folderId>", request.send(:base_elements_xml)
        }
        assert_nothing_raised {
          request = Exlibris::Primo::WebService::Request::AddToEshelf.new(
            :institution => @institution, 
            :ip => @ip, 
            :group => @group, 
            :on_campus => @on_campus, 
            :is_logged_in => @is_logged_in, 
            :pds_handle => @pds_handle, 
            :user_id => @user_id, 
            :doc_id => @doc_id, 
            :searchkey => @search_key
          )
          assert_equal "<institution>University</institution>"+
            "<ip>127.0.0.1</ip>"+
            "<group>Department</group>"+
            "<onCampus>true</onCampus>"+
            "<isLoggedIn>true</isLoggedIn>"+
            "<pdsHandle>pds_handle_dummy</pdsHandle>"+
            "<userId>user_id_dummy</userId>"+
            "<docId>doc_id_dummy</docId>"+
            "<searchkey>search_key_dummy</searchkey>", request.send(:base_elements_xml)
        }
        assert_nothing_raised {
          request = Exlibris::Primo::WebService::Request::RemoveFromEshelf.new(
            :institution => @institution, 
            :ip => @ip, 
            :group => @group, 
            :on_campus => @on_campus, 
            :is_logged_in => @is_logged_in, 
            :pds_handle => @pds_handle, 
            :user_id => @user_id, 
            :folder_id => @folder_id, 
            :doc_id => @doc_id
          )
          assert_equal "<institution>University</institution>"+
            "<ip>127.0.0.1</ip>"+
            "<group>Department</group>"+
            "<onCampus>true</onCampus>"+
            "<isLoggedIn>true</isLoggedIn>"+
            "<pdsHandle>pds_handle_dummy</pdsHandle>"+
            "<userId>user_id_dummy</userId>"+
            "<folderId>folder_id_dummy</folderId>"+
            "<docId>doc_id_dummy</docId>", request.send(:base_elements_xml)
        }
      end

      def test_search_base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle],
          Exlibris::Primo::WebService::Request::Search.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id],
          Exlibris::Primo::WebService::Request::FullView.base_elements
      end
      
      def test_new_search_base_elements
        assert_nothing_raised {
          request = Exlibris::Primo::WebService::Request::Search.new(
            :institution => @institution, 
            :ip => @ip, 
            :group => @group, 
            :on_campus => @on_campus, 
            :is_logged_in => @is_logged_in, 
            :pds_handle => @pds_handle
          )
          assert_equal "<institution>University</institution>"+
            "<ip>127.0.0.1</ip>"+
            "<group>Department</group>"+
            "<onCampus>true</onCampus>"+
            "<isLoggedIn>true</isLoggedIn>"+
            "<pdsHandle>pds_handle_dummy</pdsHandle>", request.send(:base_elements_xml)
        }
        assert_nothing_raised {
          request = Exlibris::Primo::WebService::Request::FullView.new(
            :institution => @institution, 
            :ip => @ip, 
            :group => @group, 
            :on_campus => @on_campus, 
            :is_logged_in => @is_logged_in, 
            :pds_handle => @pds_handle, 
            :doc_id => @doc_id
          )
          assert_equal "<institution>University</institution>"+
            "<ip>127.0.0.1</ip>"+
            "<group>Department</group>"+
            "<onCampus>true</onCampus>"+
            "<isLoggedIn>true</isLoggedIn>"+
            "<pdsHandle>pds_handle_dummy</pdsHandle>"+
            "<docId>doc_id_dummy</docId>", request.send(:base_elements_xml)
        }
      end

      def test_reviews_base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id],
          Exlibris::Primo::WebService::Request::Reviews.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id],
          Exlibris::Primo::WebService::Request::GetReviews.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id],
          Exlibris::Primo::WebService::Request::GetAllMyReviews.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id],
          Exlibris::Primo::WebService::Request::GetReviewsForRecord.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id, :rating],
          Exlibris::Primo::WebService::Request::GetReviewsByRating.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id, :value, :rating, :user_display_name, :allow_user_name, :status],
          Exlibris::Primo::WebService::Request::AddReview.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id],
          Exlibris::Primo::WebService::Request::RemoveReview.base_elements
      end

      def test_tags_base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id],
          Exlibris::Primo::WebService::Request::Tags.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id],
          Exlibris::Primo::WebService::Request::GetTags.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id],
          Exlibris::Primo::WebService::Request::GetAllMyTags.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id],
          Exlibris::Primo::WebService::Request::GetTagsForRecord.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :doc_id, :user_id, :value],
          Exlibris::Primo::WebService::Request::RemoveTag.base_elements
        assert_equal [:institution, :ip, :group, :on_campus, :is_logged_in, :pds_handle, :user_id],
          Exlibris::Primo::WebService::Request::RemoveUserTags.base_elements
      end
      
      def test_undefined_base_elements
        assert_nothing_raised {
          Exlibris::Primo::WebService::Request::GetEshelf.new(:not_a_base_element => "")
        }
        request = Exlibris::Primo::WebService::Request::GetEshelf.new
        assert_raise(NoMethodError) {
          request.not_a_base_element = ""
        }
      end
    end
  end
end