module Exlibris
  module Primo
    #
    # Specify global configuration settings for
    #
    module Config
      class << self
        include WriteAttributes
        attr_accessor :base_url, :institution, :libraries, :availability_statuses, :sources, 
          :facet_labels, :facet_top_level, :facet_collections, :facet_resource_types, :load_time

        def load_yaml file
          write_attributes YAML.load_file(file)
          self.load_time = Time.now
        end
      end

      #
      # These attributes default to the global config settings if not 
      # specified locally.
      #
      module Attributes
        def config
          @config ||= Config
        end

        def base_url
          @base_url ||= String.new config.base_url.to_s
        end

        def institution
          @institution ||= String.new config.institution.to_s
        end

        def libraries
          @libraries ||= config.libraries.dup
        end

        def availability_statuses
          @availability_statuses ||= config.availability_statuses.dup
        end

        def sources
          @sources ||= config.sources.dup
        end

        def facet_labels
          @facet_labels ||= config.facet_labels.dup
        end

        def facet_top_level
          @facet_top_level ||= config.facet_top_level.dup
        end

        def facet_collections
          @facet_collections ||= config.facet_collections.dup
        end

        def facet_resource_types
          @facet_resource_types ||= config.facet_resource_types.dup
        end
      end
    end
  end
end