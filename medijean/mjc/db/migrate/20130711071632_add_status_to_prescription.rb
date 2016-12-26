class AddStatusToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :status, :integer
  end
end
