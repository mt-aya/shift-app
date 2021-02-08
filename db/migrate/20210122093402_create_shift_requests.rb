class CreateShiftRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :shift_requests do |t|
      t.datetime   :start_time, null: false
      t.datetime   :end_time,   null: false
      t.boolean    :submitted
      t.references :staff_user, foreign_key: true
      t.references :board,      foreign_key: true
      t.timestamps
    end
  end
end
