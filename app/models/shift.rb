class Shift < ApplicationRecord
  belongs_to :board
  belongs_to :staff_user

  with_options presence: true do
    validates :start_time
    validates :end_time
  end

  validate :not_before_start, :not_change_date

  def not_before_start
    if start_time > end_time
      errors.add(:end_time, "は開始時間より前の時間は指定できません")
    end
  end

  def not_change_date
    if (start_day.all_day).cover?(end_day)
      errors.add(:end_time, "は開始時間と異なる日付は指定できません")
    end
  end
end
