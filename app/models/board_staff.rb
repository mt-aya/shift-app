class BoardStaff
  include ActiveModel::Model
  attr_accessor :id_name, :board_id

  with_options presence: true do
    validates :id_name
    validates :board_id
  end

  def save
    staff_users = StaffUser.search(id_name)
    board = Board.find(board_id)
    if staff_users.length == 1
      result_staff = nil
      staff_users.each do |staff_user|
        result_staff = staff_user unless board.staff_users.exists?(id: staff_user.id)
      end
      board_staff_user = BoardStaffUser.create(board_id: board_id, staff_user_id: result_staff.id)
      return result_staff
    else
      return nil
    end
  end
end