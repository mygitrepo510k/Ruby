class AddQuantityToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :quantity, :string
  end
end
