class BoardStaffUser < ApplicationRecord
  belongs_to :board
  belongs_to :staff_user
end
