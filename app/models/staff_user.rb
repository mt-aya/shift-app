class StaffUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :board_staff_users
  has_many :boards, through: :board_staff_users

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i.freeze # 英・数どちらも含む6文字以上の半角英数字
  VALID_ID_NAME_REGEX = /\A[a-z\d]{6,16}\z/i.freeze # 6~16文字の半角英数字
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze   # 全角ひらがな、カタカナ、漢字
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  validates :id_name, presence: true, uniqueness: true, format: { with: VALID_ID_NAME_REGEX }
  with_options presence: true, format: { with: VALID_NAME_REGEX } do
    validates :last_name
    validates :first_name
  end

  def self.search(search)
    StaffUser.where(id_name: search) if search != ''
  end
end
