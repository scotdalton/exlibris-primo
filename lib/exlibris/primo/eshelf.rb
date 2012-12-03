module Exlibris
  module Primo
    #
    #
    #
    class EShelf
      include BaseAttributes
      include Config::Attributes
      include RequestAttributes
      include WriteAttributes

      attr_accessor :user_id

      def initialize *args
        super
      end

      #
      # Call web service to get Eshelf contents and return
      #
      def eshelf
        @eshelf ||= Exlibris::Primo::WebService::Request::GetEshelf.new(user_request_attributes).call
      end

      #
      # Call web service to get Eshelf structure and return
      #
      def eshelfStructure
        @eshelfStructure ||= Exlibris::Primo::WebService::Request::GetEshelfStructure.new(user_request_attributes).call
      end

      #
      # Get the number of records in user's eshelf
      #
      def count
        @count ||= eshelf.count
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
        @basket_id ||= eshelfStructure.basket_id
      end

      #
      # Call web service to add records to eshelf
      #
      def add_records(record_ids, folder_id)
        record_ids.each do |record_id|
          add_record record_id, folder_id
        end
      end

      #
      # Call web service to add record to eshelf
      #
      def add_record(record_id, folder_id)
        Exlibris::Primo::WebService::Request::AddToEshelf.new(user_request_attributes.merge :folder_id => folder_id, :doc_id => record_id).call
      end

      #
      # Call web service to add records to eshelf
      #
      def remove_records(record_ids, folder_id)
        record_ids.each do |record_id|
          remove_record record_id, folder_id
        end
      end

      #
      # Call web service to remove record from eshelf
      #
      def remove_record(record_id, folder_id)
        Exlibris::Primo::WebService::Request::RemoveFromEshelf.new(user_request_attributes.merge :folder_id => folder_id, :doc_id => record_id).call
      end
    end
  end
end