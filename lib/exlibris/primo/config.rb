module Exlibris
  module Primo
    #
    # Specify global configuration settings for
    #
    module Config
      class << self
        include WriteAttributes
        attr_accessor :base_url, :institution, :libraries, :availability_statuses,
          :sources, :facet_labels, :facet_top_level, :facet_collections, :facet_resource_types

        def load_yaml file
          write_attributes YAML.load_file(file)
        end
      end

      #
      #
      #
      module Attributes
        def config
          @config ||= Config
        end

        def base_url
          @base_url ||= String.new Config.base_url.to_s
        end

        def institution
          @institution ||= String.new Config.institution.to_s
        end

        def libraries
          @libraries ||= Config.libraries.dup
        end

        def availability_statuses
          @availability_statuses ||= Config.availability_statuses.dup
        end

        def sources
          @sources ||= Config.sources.dup
        end

        def facet_labels
          @facet_labels ||= Config.facet_labels.dup
        end

        def facet_top_level
          @facet_top_level ||= Config.facet_top_level.dup
        end

        def facet_collections
          @facet_collections ||= Config.facet_collections.dup
        end

        def facet_resource_types
          @facet_resource_types ||= Config.facet_resource_types.dup
        end
      end
    end
  end
end