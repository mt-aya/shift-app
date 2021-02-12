FactoryBot.define do
  factory :shift_request do
    start_time { DateTime.current.noon }
    end_time   { start_time + 5.hour }
    submitted  { false }
    association :staff_user
    association :board
  end
end
