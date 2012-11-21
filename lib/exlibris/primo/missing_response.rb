module Exlibris
  module Primo
    module MissingResponse
      #
      # Make work for Ruby 1.8
      #
      def respond_to_missing? method, include_private=false
        (super || respond_to?) ? true : false
      end
    end
  end
end