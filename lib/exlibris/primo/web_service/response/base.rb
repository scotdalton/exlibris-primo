module Exlibris
  module Primo
    module WebService
      module Response
        class Base
          include Abstract
          include Error
          include Namespaces
          include Util
          include XmlUtil
          self.abstract = true

          attr_reader :savon_response, :soap_action, :code, :body
          protected :savon_response, :soap_action

          def initialize savon_response, soap_action
            super
            @savon_response = savon_response
            @code = savon_response.http.code
            @body = savon_response.http.body
            @soap_action = soap_action
            # Since there seem to be a problem parsing strings with unescaped 
            # ampersands in Nokogiri for java/jruby we need to
            # force ' & ' to ' &amp; '; may have to do with
            # https://github.com/sparklemotion/nokogiri/issues/614
            @raw_xml = 
              savon_response.body[response_key][return_key].gsub(' & ', ' &amp; ')
          end
        end
      end
    end
  end
end