class AddFieldsToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :prescription_number, :string
    add_column :prescriptions, :current_usage_habits, :string
  end
end
