class RemoveStrainFromprescription < ActiveRecord::Migration
  def change
    remove_column :prescriptions, :strain
  end
end
