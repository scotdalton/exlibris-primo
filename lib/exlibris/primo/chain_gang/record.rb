module Exlibris
  module Primo
    module ChainGang
      module Record
        attr_reader :record_id

        # 
        # Set the record_id
        # 
        def record_id!(record_id)
          @record_id = record_id
          self
        end
        alias :record_id= :record_id!
      end
    end
  end
end