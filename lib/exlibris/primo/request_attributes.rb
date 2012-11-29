module Exlibris
  module Primo
    module RequestAttributes
      def request_attributes
        @request_attributes ||= {:base_url =>base_url, :institution => institution}
      end
      protected :request_attributes
    end
  end
end