module Exlibris
  module Primo
    # 
    # 
    # 
    module Config
      class << self
        include WriteAttributes
        attr_accessor :base_url, :libraries, :availability_statuses, :sources
        
        def load_yaml file
          write_attributes YAML.load_file(file)
        end
      end
    end
  end
end