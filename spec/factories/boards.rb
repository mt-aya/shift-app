FactoryBot.define do
  factory :board do
    name { Faker::Team.name }
    association :owner
  end
end
