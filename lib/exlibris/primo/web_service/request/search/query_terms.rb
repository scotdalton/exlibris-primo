module Exlibris
  module Primo
    module WebService
      module QueryTerms
        def self.included(klass)
          klass.class_eval do
            def self.query_terms
              @query_terms ||= {
                :isbn => {:precision => "exact"}, 
                :issn => {:precision => "exact", :index => "isbn"}, 
                :title => {:precision => "contains"}, 
                :author => {:precision => "contains", :index => "creator"}, 
                :genre => {:precision => "exact", :index => "any"}
              }
            end
            # Splat the keys to define accessors
            attr_accessor *query_terms.keys
          end
        end

        def query_terms(bool_operator="AND")
          # Set a hash of values, indexes and precisions
          # to pass into the closure.
          qts = self.class.query_terms.dup
          qts.each do |qt, config|
            qts[qt][:value] = send qt
            qts[qt][:index] = config[:index] ? config[:index] : qt.id2name
          end
          build_xml do |xml|
            xml.QueryTerms {
              xml.BoolOpeator bool_operator
              qts.each_value do |qt|
                xml << query_term(qt[:value], qt[:index], qt[:precision]) unless qt[:value].nil?
              end
            }
          end
        end
        protected :query_terms

        def query_term(value, index, precision)
          build_xml do |xml|
            xml.QueryTerm {
              xml.IndexField index
              xml.PrecisionOperator precision
              xml.Value value
            }
          end
        end
        private :query_term
      end
    end
  end
end