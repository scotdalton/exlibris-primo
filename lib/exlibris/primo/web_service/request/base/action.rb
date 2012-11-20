module Exlibris
  module Primo
    module WebService
      module Request
        module Action
          def self.included(klass)
            klass.class_eval do
              extend Config
            end
          end

          module Config
            def action
              @action ||= name.demodulize.underscore.to_sym
            end
            attr_writer :action
            protected :action=
          end

          def action
            @action ||= self.class.action
          end
        end
      end
    end
  end
end