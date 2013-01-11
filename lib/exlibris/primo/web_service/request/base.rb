module Exlibris
  module Primo
    module WebService
      module Request
        # 
        # Abstract base class for Primo interactions
        # 
        class Base
          include Abstract
          include BaseElements
          include Client
          include Call
          include Config::Attributes
          include Namespaces
          include SoapAction
          include WriteAttributes
          include XmlUtil
          self.abstract = true
          self.add_base_elements :institution, :ip, :group, 
            :on_campus, :is_logged_in, :pds_handle

          DEFAULT_WRAPPER = :request
          attr_reader :root, :wrapper
          protected :root, :wrapper
          attr_writer :base_url, :institution

          def initialize *args
            super
            @root = "#{self.class.name.demodulize}Request".camelize(:lower).to_sym
            @wrapper = DEFAULT_WRAPPER.id2name.camelize(:lower).to_sym
          end

          def to_xml &block
            namespaces = request_namespaces
            build_xml { |xml|
              xml.send(wrapper) {
                xml.cdata build_xml { |xml|
                  xml.send(root, namespaces) {
                    yield xml if block
                    xml << base_elements_xml
                  }
                }
              }
            }
          end
        end

        # 
        # Abstract class for Primo user interactions
        # 
        class UserBase < Base
          # Add user_id to the base elements
          self.add_base_elements :user_id
          self.abstract = true
        end

        # 
        # Abstract class for Primo record interactions
        # 
        class Record < Base
          # Add doc_id to the base elements
          self.add_base_elements :doc_id
          self.abstract = true
        end

        # 
        # Abstract class for Primo user/record interactions
        # 
        class UserRecord < Record
          # Add user_id to the base elements
          self.add_base_elements :user_id
          self.abstract = true
        end
      end
    end
  end
end