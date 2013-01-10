module Exlibris
  module Primo
    #
    # Manipulate a user's Primo eshelf using Exlibris::Primo::Eshelf
    #
    #     eshelf = Eshelf.new.base_url!("http://primo.library.edu").institution!("PRIMO").user_id!("USER_ID")
    #     eshelf.records #=> Array for Primo records
    #
    class EShelf
      include Config::Attributes
      include ChainGang::Base
      include ChainGang::User
      include RequestAttributes
      include WriteAttributes

      attr_reader :user_id

      def initialize *args
        super
      end

      #
      # Call web service to get Eshelf contents and return
      #
      def eshelf
        @eshelf ||= 
          Exlibris::Primo::WebService::Request::GetEshelf.new(user_request_attributes).call
      end

      #
      # Call web service to get Eshelf structure and return
      #
      def eshelf_structure
        @eshelf_structure ||= 
          Exlibris::Primo::WebService::Request::GetEshelfStructure.new(user_request_attributes).call
      end

      #
      # Get the number of records in user's eshelf
      #
      def size
        @size ||= eshelf.size
      end

      #
      # Get all the records from user's eshelf as an array of Primo Record objects
      #
      def records
        @records ||= eshelf.records
      end

      #
      # Get the default basket id from eshelf structure web service call
      #
      def basket_id
        @basket_id ||= eshelf_structure.basket_id
      end

      #
      # Get the folder id from eshelf structure web service call
      # for the given folder name.
      #
      def folder_id(folder_name)
        eshelf_structure.folder_id(folder_name)
      end

      #
      # Call web service to add records to eshelf
      #
      def add_records(record_ids, folder_id)
        record_ids.each do |record_id|
          add_record record_id, folder_id
        end
        reset_eshelf
      end

      #
      # Call web service to add record to eshelf
      #
      def add_record(record_id, folder_id)
        Exlibris::Primo::WebService::Request::AddToEshelf.new(
          user_request_attributes.merge :folder_id => folder_id, :doc_id => record_id).call
        reset_eshelf
      end

      #
      # Call web service to remove records from the eshelf
      #
      def remove_records(record_ids, folder_id)
        record_ids.each do |record_id|
          remove_record record_id, folder_id
        end
        reset_eshelf
      end

      #
      # Call web service to remove a record from eshelf
      #
      def remove_record(record_id, folder_id)
        Exlibris::Primo::WebService::Request::RemoveFromEshelf.new(
          user_request_attributes.merge :folder_id => folder_id, :doc_id => record_id).call
        reset_eshelf
      end

      #
      # Call web service to add folder to eshelf
      #
      def add_folder(folder_name, parent_id)
        Exlibris::Primo::WebService::Request::AddFolderToEshelf.new(
          user_request_attributes.merge :folder_name => folder_name, :parent_folder => parent_id).call
        reset_eshelf
      end

      #
      # Call web service to remove folder from eshelf
      #
      def remove_folder(folder_id)
        Exlibris::Primo::WebService::Request::RemoveFolderFromEshelf.new(
          user_request_attributes.merge :folder_id => folder_id).call
        reset_eshelf
      end

      # Reset eshelf instance variables
      def reset_eshelf
        @eshelf = nil
        @eshelf_structure = nil
        @size = nil
        @records = nil
        @basket_id = nil
      end
      private :reset_eshelf
    end
  end
end