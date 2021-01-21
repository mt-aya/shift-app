class Shift < ApplicationRecord
  belongs_to :board
  belongs_to :staff_user

  with_options presence: true do
    validates :start_time
    validates :end_time
  end

  validate :not_before_start, :not_change_date, :not_doubling

  def not_before_start
    if start_time > end_time
      errors.add(:end_time, "は開始時間より前の時間は指定できません")
    end
  end

  def not_change_date
    unless (start_time.all_day).cover?(end_time)
      errors.add(:end_time, "は開始時間と異なる日付は指定できません")
    end
  end

  def not_doubling
    unless id.present?
      same_date_shifts = Shift.where(staff_user_id: staff_user_id, board_id: board_id, start_time: start_time.all_day)
      same_date_shifts.each do |shift|
        if shift.start_time <= end_time && shift.end_time >= start_time
          errors.add(:base, "同じユーザーに既に登録されている期間と重複するものは指定できません")
        end
      end
    end
  end
end
