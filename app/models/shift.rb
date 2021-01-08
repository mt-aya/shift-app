class Shift < ApplicationRecord
  belongs_to: shift_frame
  belongs_to: staff_user
end
