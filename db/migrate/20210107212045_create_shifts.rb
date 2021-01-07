class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.datetime   :start_time,     null: false
      t.datetime   :end_time,       null: false
      t.references :staff_user,  foreign_key: true
      t.references :shift_frame, foreign_key: true
      t.timestamps
    end
  end
end
