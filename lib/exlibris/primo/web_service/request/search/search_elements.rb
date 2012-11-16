module Exlibris
  module Primo
    module WebService
      module SearchElements
        def self.included(klass)
          klass.class_eval do
            def self.search_elements
              @search_elements ||= {
                :start_index => {:default => "1"},
                :bulk_size => {:default => "5"},
                :did_u_mean_enabled => {:default => "false"},
                :highlighting_enabled => {:default => "false"},
                :get_more => {},
                :locations => {},
                :inst_boost => {:default => "true"}
              }
            end
            attr_accessor *search_elements.keys
          end
        end

        def search_elements
          search_elements = ""
          self.class.search_elements.each do |opt, config|
            value = send(opt) ? send(opt) : config[:default]
            name = opt.id2name.camelize
            search_elements << build_xml do |xml|
              xml.send(name, value) unless value.nil?
            end
          end
          search_elements
        end
        protected :search_elements
      end
    end
  end
end