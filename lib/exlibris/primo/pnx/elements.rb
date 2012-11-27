module Exlibris
  module Primo
    module Pnx
      module Elements
        #
        #
        #
        def method_missing(method, *args, &block)
          if(attr_read(method))
            self.class.send(:define_method, method) {
              eval("@#{method} ||= \"#{attr_read method}\"")
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
          (attr_read(method) || super) ? true : false
        end

        def attr_read method
          (inner_text(xpathize(method)) || inner_text(controlize(method)))
        end
        private :attr_read

        def inner_text xpath
          xml_at = xml.root.at_xpath(xpath)
          xml_at.inner_text if xml_at
        end
        private :inner_text

        def controlize s
          "control/#{xpathize s.to_s}"
        end
        private :controlize

        def xpathize s
          "#{s.to_s}".gsub(/_/, "/").gsub(/[=\[\]]/, "")
        end
        private :xpathize
      end
    end
  end
end