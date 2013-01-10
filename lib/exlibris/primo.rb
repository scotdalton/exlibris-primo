module Exlibris
  module Primo
    class << self
      def configure
        yield config
      end

      def config
        @config ||= Config
      end
    end
  end
end