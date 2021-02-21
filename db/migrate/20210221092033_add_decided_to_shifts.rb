class AddDecidedToShifts < ActiveRecord::Migration[6.0]
  def change
    add_column :shifts, :decided, :boolean
  end
end
