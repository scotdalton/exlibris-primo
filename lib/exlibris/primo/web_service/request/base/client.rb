module Exlibris
  module Primo
    module WebService
      module Request
        module Client
          def self.included(klass)
            klass.class_eval do
              extend ClassAttributes
            end
          end

          module ClassAttributes
            def client
              @client ||= (has_client?) ? name.demodulize.underscore.to_sym :
                (self.superclass.respond_to? :client) ?
                  self.superclass.client : nil
            end

            # Returns whether this class has a client symbol
            def has_client?
              @has_client ||= false
            end
            protected :has_client?

            # Tell the class it hold the client symbol
            def has_client
              @has_client = true
            end
            protected :has_client
          end

          def client
            @client ||= client_klass.new :base_url => base_url
          end
          protected :client

          def client_klass
            "Exlibris::Primo::WebService::Client::#{self.class.client.to_s.camelize}".constantize
          end
          private :client_klass
        end
      end
    end
  end
end