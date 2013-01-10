module Exlibris
  module Primo
    module ChainGang
      module User
        attr_reader :user_id

        # 
        # Set the user id
        # 
        def user_id!(user_id)
          @user_id = user_id
          self
        end
        alias :user_id= :user_id!
      end
    end
  end
end