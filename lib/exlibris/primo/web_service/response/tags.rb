module Exlibris
  module Primo
    module WebService
      module Response
        # 
        # 
        # 
        class Tags < Base
          self.abstract = true
        end

        # 
        # 
        # 
        class GetTags < Tags
          def my_tags
            @my_tags ||= xml.root.xpath("//tags_reviews:MyTags/tags_reviews:Tag", response_namespaces).collect { |tag|
                Exlibris::Primo::Tag.new(:raw_xml => tag.to_xml) }
          end

          def everybody_tags
            @everybody_tags ||= xml.root.xpath("//tags_reviews:EverybodyTags/tags_reviews:Tag", response_namespaces).collect { |tag|
                Exlibris::Primo::Tag.new(:raw_xml => tag.to_xml) }
          end
        end

        # 
        # 
        # 
        class GetAllMyTags < GetTags; end

        # 
        # 
        # 
        class GetTagsForRecord < GetTags; end

        # 
        # 
        # 
        class AddTag < Tags; end

        # 
        # 
        # 
        class RemoveTag < Tags; end

        # 
        # 
        # 
        class RemoveUserTags < Tags; end
      end
    end
  end
end