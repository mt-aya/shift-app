class CreateBoardStaffUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :board_staff_users do |t|
      t.references :board,      foreign_key: true
      t.references :staff_user, foreign_key: true
      t.timestamps
    end
  end
end
