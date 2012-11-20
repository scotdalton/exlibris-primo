module Exlibris
  module Primo
    module WebService
      module Response
        class Base
          include Abstract
          include Namespaces
          include Util
          include XmlUtil
          self.abstract = true

          attr_reader :savon_response, :action
          protected :savon_response, :action
          def initialize savon_response, action
            super
            @savon_response = savon_response
            @action = action
            @raw_xml = savon_response.body[response_key][return_key]
          end
        end
      end
    end
  end
end