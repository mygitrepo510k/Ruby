class RemoveState < ActiveRecord::Migration
  def change
    drop_table :states
    rename_column :orders, :state_id, :status
    rename_column :doctor_patients, :state_id, :status
  end
end
