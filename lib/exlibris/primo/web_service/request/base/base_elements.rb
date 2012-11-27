module Exlibris
  module Primo
    module WebService
      module Request
        module BaseElements
          def self.included(klass)
            klass.class_eval do
              extend Config
            end
          end

          module Config
            def base_elements
              @base_elements ||= self.superclass.respond_to?(:base_elements) ?
                self.superclass.base_elements.dup : []
            end

            def add_base_elements *elements
              elements.each do |element|
                base_elements << element unless base_elements.include? element
              end
            end

            def remove_base_elements *elements
              base_elements.delete_if do |element|
                elements.include? element
              end
            end
          end

          def base_elements
            @base_element ||= self.class.base_elements
          end

          def base_elements_xml
            (base_elements.collect { |opt|
              value = send(opt)
              name = opt.id2name.camelize(:lower)
              build_xml do |xml|
                xml.send(name, value) unless value.nil?
              end
            }).join
          end
          protected :base_elements_xml

          #
          # Dynamically sets attr_accessors for base_elements
          #
          def method_missing(method, *args, &block)
            if self.class.base_elements.include?(attributize(method))
              self.class.send :attr_accessor, attributize(method)
              send method, *args, &block
            else
              super
            end
          end

          #
          # Tell users that we respond to base elements accessors.
          #
          def respond_to?(method, include_private = false)
            (base_elements.include?(attributize method)) ? true : super
          end

          def attributize symbol
            symbol.id2name.sub(/=$/, "").to_sym
          end
        end
      end
    end
  end
end