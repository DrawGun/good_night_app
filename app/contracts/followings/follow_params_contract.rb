module Followings
  class FollowParamsContract < Dry::Validation::Contract
    params do
      required(:user_id).value(:integer)
      required(:followings).hash do
        required(:followee_id).value(:integer)
      end
    end
  end
end
