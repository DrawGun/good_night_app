FactoryBot.define do
  factory :sleep_period do
    fall_asleep { 2.days.ago }
    wake_up { 1.day.ago }
    value { 1.day.ago.to_i - 2.days.ago.to_i  }
    user { association :user }
  end
end
