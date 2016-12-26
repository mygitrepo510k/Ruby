class AddColumnsToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :current_dosage, :integer
    add_column :prescriptions, :dosage, :integer
    add_column :prescriptions, :item_id, :integer
    add_column :prescriptions, :administration_method, :integer
    add_column :prescriptions, :expiration, :date
  end
end
