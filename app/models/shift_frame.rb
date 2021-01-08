class ShiftFrame < ApplicationRecord
  has_many :shifts
  belongs_to :board

  with_options presence: true do
    validates :start_day
    validates :end_day
  end

  validate :not_before_start

  def not_before_start
    if start_day > end_day || end_day == nil || start_day == nil
      errors.add(:end_day, "は開始日より前の日付は設定できません")
    end
  end

end
