class RemovefieldsPrescriptions < ActiveRecord::Migration
  def change
    remove_column :prescriptions, :prescription_number
    remove_column :prescriptions, :quantity
  end
end
