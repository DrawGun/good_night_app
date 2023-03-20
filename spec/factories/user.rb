FactoryBot.define do
  factory :user do
    sequence(:name) do |n|
      "Name_#{n}"
    end
  end
end
