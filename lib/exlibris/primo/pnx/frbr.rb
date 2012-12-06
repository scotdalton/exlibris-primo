module Exlibris
  module Primo
    module Pnx
      # 
      # Handle frbr records
      # 
      module Frbr
        #
        # Is this a frbr'd record
        #
        def frbr?
          @frbr ||= (respond_to? :facets_frbrgroupid)
        end

        #
        # Returns the frbr id of this record if there is one.
        #
        def frbr_id
          @frbr_id ||= facets_frbrgroupid if frbr?
        end
      end
    end
  end
end