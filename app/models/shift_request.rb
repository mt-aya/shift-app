class ShiftRequest < ApplicationRecord
  belongs_to :board
  belongs_to :staff_user

  with_options presence: true do
    validates :start_time
    validates :end_time
  end

  validate :not_before_start, :not_change_date, :not_doubling

  def not_before_start
    errors.add(:end_time, 'は開始時刻より前の時刻は指定できません') if start_time.present? && end_time.present? && start_time > end_time
  end

  def not_change_date
    if start_time.present? && end_time.present? && !(start_time.all_day).cover?(end_time)
      errors.add(:end_time, 'は開始時刻と異なる日付は指定できません')
    end
  end

  def not_doubling
    if start_time.present? && end_time.present? && id.blank?
      same_date_shifts = ShiftRequest.where(staff_user_id: staff_user_id, start_time: start_time.all_day)
      same_date_shifts.each do |shift|
        errors.add(:base, '同じユーザーに既に登録されている期間と重複するものは指定できません') if shift.start_time <= end_time && shift.end_time >= start_time
      end
    end
  end

  def self.search(params)
    start_term = Time.zone.parse(params[:start_term]).midnight if params[:start_term].present?
    end_term = Time.zone.parse(params[:end_term]).end_of_day if params[:end_term].present?
    ShiftRequest.where(board_id: params[:board_id], staff_user_id: params[:staff_user_id], start_time: start_term..end_term, submitted: false)
  end
end
