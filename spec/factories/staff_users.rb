FactoryBot.define do
  factory :staff_user do
    email { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 4)
    password              { password }
    password_confirmation { password }
    id_name               { Faker::Lorem.characters(number: 16) }
    last_name             { Gimei.last.kanji }
    first_name            { Gimei.first.kanji }
  end
end
