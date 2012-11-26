module Exlibris
  module Primo
    #
    #
    #
    module Config
      class << self
        include WriteAttributes
        attr_accessor :base_url, :vid, :institution, :libraries, :availability_statuses, :sources

        def load_yaml file
          write_attributes YAML.load_file(file)
        end
      end

      #
      #
      #
      module Attributes
        attr_writer :base_url, :vid, :institution

        def base_url
          @base_url ||= String.new Config.base_url.to_s
        end

        def vid
          @vid ||= String.new Config.vid.to_s
        end

        def institution
          @institution ||= String.new Config.institution.to_s
        end
      end
    end
  end
end