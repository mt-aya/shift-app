FactoryBot.define do
  factory :owner do
    email                 { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 4)
    password              { password }
    password_confirmation { password }
    company               { 'aA1 あぁ(株)' }
    last_name             { Gimei.last.kanji }
    first_name            { Gimei.first.kanji }
  end
end