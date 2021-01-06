class Board < ApplicationRecord
  has_many :board_staff_users
  has_many :staff_users, through: :board_staff_users
  belongs_to :owner

  validates :name, presence: true
end
