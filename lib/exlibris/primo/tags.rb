module Exlibris
  module Primo
    #
    # Manipulate a Primo tags using Exlibris::Primo::Tags
    # 
    #     tags = Tags.new.base_url!("http://primo.library.edu").institution!("PRIMO").
    #       user_id!("USER_ID").record_id!("aleph0123456789")
    #     tag.my_tags #=> Array of Primo tags
    #
    class Tags
      include Config::Attributes
      include ChainGang::Base
      include ChainGang::User
      include ChainGang::Record
      include RequestAttributes
      include WriteAttributes

      attr_reader :user_id, :record_id

      def initialize *args
        super
      end

      #
      # Get tags for the specified user and record
      #
      def tags
        @tags ||= get_tags.my_tags
      end

      #
      # Get all tags for the specified user
      #
      def record_tags
        @record_tags ||= get_tags.everybody_tags
      end

      #
      # Get all tags for the specified user
      #
      def user_tags
        @user_tags ||= Exlibris::Primo::WebService::Request::GetAllMyTags.
          new(user_request_attributes).call.my_tags
      end

      #
      # Call web service to add tags to Primo for the specified record
      #
      def add_tags(tags)
        tags.each do |tag|
          add_tag tag
        end
      end

      #
      # Call web service to add a tag to Primo for the specified record
      #
      def add_tag(tag)
        Exlibris::Primo::WebService::Request::AddTag.
          new(user_record_request_attributes.merge :value => tag).call
      end

      #
      # Call web service to remove tags from Primo for the specified record
      #
      def remove_tags(tags)
        tags.each do |tag|
          remove_tag tag
        end
      end

      # 
      # Remove all users tags
      # 
      def remove_user_tags
        Exlibris::Primo::WebService::Request::RemoveUserTags.
          new(user_request_attributes).call
      end

      #
      # Call web service to remove tag from Primo for the specified record
      #
      def remove_tag(tag)
        Exlibris::Primo::WebService::Request::RemoveTag.
          new(user_record_request_attributes.merge :value => tag).call
      end

      def get_tags
        @get_tags ||= Exlibris::Primo::WebService::Request::GetTags.
          new(user_record_request_attributes).call
      end
      private :get_tags
    end
  end
end