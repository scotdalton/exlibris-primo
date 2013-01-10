module Exlibris
  module Primo
    module Pnx
      # 
      # Provides access to PNX elements
      # 
      module Elements
        #
        # Parses elements from PNX base on the pattern
        # parentname_childname e.g.
        #     record.display_title #=> "Travels with my aunt"
        # based on the XML
        #     <record>
        #       ...
        #       <display>
        #         ...
        #         <title>Travels with my aunt</title>
        #         ...
        #       </display>
        #       ...
        #     </record>
        #
        def method_missing(method, *args, &block)
          if(attr_read(method))
            self.class.send(:define_method, method) {
              if "#{method}".start_with? "all_"
                eval("@#{method} ||= #{attr_read(method).inspect}")
              else
                eval("@#{method} ||= #{attr_read(method).inspect}")
              end
            }
            send method, *args, &block
          else
            super
          end
        end

        #
        # Tell user we respond to PNX elements
        #
        def respond_to?(method, include_private=false)
          (attr_read(method)) ? true : super
        end

        def attr_read method
          if("#{method}".start_with? "all_")
            (inner_text_all(xpathize(method)) || inner_text_all(controlize(method)))
          else
            (inner_text_at(xpathize(method)) || inner_text_at(controlize(method)))
          end
        end
        private :attr_read

        def inner_text_all xpath
          xml.root.xpath(xpath).collect do |element|
            element.inner_text
          end
        end
        private :inner_text_all

        def inner_text_at xpath
          xml_at = xml.root.at_xpath(xpath)
          xml_at.inner_text if xml_at
        end
        private :inner_text_at

        def controlize s
          "control/#{xpathize s.to_s}"
        end
        private :controlize

        def xpathize s
          "#{s.to_s}".gsub(/^all_/, "").gsub(/_/, "/").gsub(/[=\[\]]/, "")
        end
        private :xpathize
      end
    end
  end
end