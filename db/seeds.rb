5.times do |n|
  Shift.create!(
    start_time: DateTime.parse("#{n + 10}/01/2021 17:00 +09:00"),
    end_time: DateTime.parse("#{n + 10}/01/2021 21:00 +09:00"),
    staff_user_id: 1,
    board_id: 11
  )
end

5.times do |n|
  Shift.create!(
    start_time: DateTime.parse("#{n + 10}/01/2021 13:00 +09:00"),
    end_time: DateTime.parse("#{n + 10}/01/2021 21:00 +09:00"),
    staff_user_id: 11,
    board_id: 11
  )
end

5.times do |n|
  Shift.create!(
    start_time: DateTime.parse("#{n + 5}/01/2021 17:00 +09:00"),
    end_time: DateTime.parse("#{n + 5}/01/2021 21:00 +09:00"),
    staff_user_id: 4,
    board_id: 11
  )
end

5.times do |n|
  Shift.create!(
    start_time: DateTime.parse("#{n + 5}/01/2021 13:00 +09:00"),
    end_time: DateTime.parse("#{n + 5}/01/2021 21:00 +09:00"),
    staff_user_id: 11,
    board_id: 11
  )
end
