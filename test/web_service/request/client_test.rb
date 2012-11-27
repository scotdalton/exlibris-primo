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
    end
  end
end