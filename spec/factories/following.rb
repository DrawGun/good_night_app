FactoryBot.define do
  factory :following do
    follower { association :user }
    followee { association :user }
  end
end
