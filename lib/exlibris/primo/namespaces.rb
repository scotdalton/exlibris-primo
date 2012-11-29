module Exlibris
  module Primo
    module Namespaces
      def self.included(klass)
        klass.class_eval do
          extend ClassAttributes
        end
      end

      module ClassAttributes
        def response_namespaces
          @response_namespaces = {
            "search" => "http://www.exlibrisgroup.com/xsd/jaguar/search",
            "eshelf" => "http://www.exlibris.com/primo/xsd/primoeshelffolder",
            "pnx" => "http://www.exlibrisgroup.com/xsd/primo/primo_nm_bib",
            "tags_reviews" => "http://com/exlibris/primo/xsd/tagsAndReview/config"
          }
        end

        def request_namespaces
          @request_namespaces = {
            "xmlns" => "http://www.exlibris.com/primo/xsd/wsRequest",
            "xmlns:uic" => "http://www.exlibris.com/primo/xsd/primoview/uicomponents"
          }
        end
      end

      def response_namespaces
        @response_namespaces ||= self.class.response_namespaces
      end
      protected :response_namespaces

      def request_namespaces
        @request_namespaces ||= self.class.request_namespaces
      end
      protected :request_namespaces
    end
  end
end