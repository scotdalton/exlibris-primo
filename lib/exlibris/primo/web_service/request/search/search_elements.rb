module Exlibris
  module Primo
    module WebService
      module SearchElements
        def self.included(klass)
          klass.class_eval do
            def self.default_search_elements
              @default_search_elements ||= {
                :start_index => "1",
                :bulk_size => "5",
                :did_u_mean_enabled => "false"
              }
            end
            
            def self.search_elements
              @search_elements ||= [
                :start_index, :bulk_size, :did_u_mean_enabled,
                :highlighting_enabled, :get_more, :locations,
                :inst_boost ]
            end
            attr_accessor *search_elements
          end
        end

        def search_elements
          search_elements = ""
          self.class.search_elements.each do |element|
            value = send(element) ? send(element) : self.class.default_search_elements[element]
            name = element.id2name.camelize
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