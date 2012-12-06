module Exlibris
  module Primo
    module Pnx
      # 
      # Handle PNX dedupmgr elements
      # 
      module DedupMgr

        def self.included(klass)
          klass.class_eval do
            extend ClassAttributes
          end
        end

        module ClassAttributes
          def duplicated_control_attributes
            @duplicated_control_attributes ||= self.superclass.respond_to?(:duplicated_control_attributes) ?
              self.superclass.duplicated_control_attributes.dup : []
          end

          def add_duplicated_control_attributes *elements
            elements.each do |element|
              duplicated_control_attributes << element unless duplicated_control_attributes.include? element
            end
          end
          protected :add_duplicated_control_attributes

          def remove_duplicated_control_attributes *elements
            duplicated_control_attributes.delete_if do |element|
              elements.include? element
            end
          end
          protected :remove_duplicated_control_attributes
        end

        #
        #
        #
        def dedup_mgr?
          @dedup_mgr ||= recordid.match /\Adedupmrg/
        end

        #
        #
        #
        def duplicated_control_attributes
          @duplicated_control_attributes ||= self.class.duplicated_control_attributes
        end
        protected :duplicated_control_attributes

        #
        #
        #
        def method_missing(method, *args, &block)
          if(duplicated_control_attributes.include? method)
            control_attribute = method.id2name.singularize
            self.class.send(:define_method, method) do
              eval("@#{method} ||= (dedup_mgr?) ?
                map_values_to_origins(\"#{control_attribute}\") : {recordid => #{control_attribute}}")
            end
            send method, *args, &block
          else
            super
          end
        end

        #
        # Tell users we respond to pluralized PNX control elements
        #
        def respond_to?(method, include_private=false)
          # WARNING: We should be calling `super` here, but that gives 
          # us an infinite loop for some reason.  Not sure why
          (duplicated_control_attributes.include? method) ? true : super
        end

        #
        #
        #
        def map_values_to_origins(field)
          values_to_origins_map = {}
          xml.root.xpath("control/#{field}").each do |element|
            # Parse subfields, O is origin, V is value
            subfields = parse_subfields(element.inner_text)
            # Map values to the origin
            values_to_origins_map[subfields["O"]] = subfields["V"]
          end
          values_to_origins_map
        end
        private :map_values_to_origins
      end
    end
  end
end