module Exlibris
  module Primo
    module Pnx
      module Frbr
        #
        #
        #
        def frbr?
          @frbr ||= (respond_to? :facets_frbrgroupid)
        end

        #
        #
        #
        def frbr_id
          @frbr_id ||= facets_frbrgroupid if frbr?
        end
      end
    end
  end
end