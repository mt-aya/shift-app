class CreateShiftFrames < ActiveRecord::Migration[6.0]
  def change
    create_table :shift_frames do |t|
      t.datetime   :start_day, null: false
      t.datetime   :end_day,   null: false
      t.references :board,  foreign_key: true
      t.timestamps
    end
  end
end
