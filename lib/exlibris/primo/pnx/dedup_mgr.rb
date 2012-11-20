module Exlibris
  module Primo
    module Pnx
      module DedupMgr

        def self.included(klass)
          klass.class_eval do
            extend Config
          end
        end

        module Config
          def duplicated_control_attributes
            @duplicated_control_attributes ||= [
              :sourcerecordids,
              :sourceids,
              :originalsourceids,
              :sourceformats,
              :sourcesystems,
              :ilsapiids]
          end
        end

        #
        #
        #
        def dedup_mgr?
          @dedup_mgr ||= recordid.match /\Adedupmrg/
        end

        #
        #
        #
        def duplicated_control_attributes
          @duplicated_control_attributes ||= self.class.duplicated_control_attributes
        end

        #
        #
        #
        def method_missing(method, *args, &block)
          if(duplicated_control_attributes.include? method)
            control_attribute = method.id2name.singularize
            self.class.send(:define_method, method) do
              eval("@#{method} ||= (dedup_mgr?) ?
                process_control_hash(\"/record/control/#{control_attribute}\") : {recordid => #{control_attribute}}")
            end
            send method, *args, &block
          else
            super
          end
        end

        #
        #
        #
        def respond_to_missing?(method, include_private=false)
          (not duplicated_control_attributes.include?(method)) ?
            (defined? super) ? super : false : true
        end

        #
        #
        #
        def process_control_hash(xpath)
          h = {}
          xml.xpath(xpath).each do |e|
            str = e.inner_text unless e.nil?
            a = str.split(/\$(?=\$)/) unless str.nil?
            v = nil
            o = nil
            a.each do |s|
              v = s.sub!(/^\$V/, "") unless s.match(/^\$V/).nil?
              o = s.sub!(/^\$O/, "") unless s.match(/^\$O/).nil?
            end
            h[o] = v unless (o.nil? or v.nil?)
          end
          return h
        end
        private :process_control_hash
      end
    end
  end
end