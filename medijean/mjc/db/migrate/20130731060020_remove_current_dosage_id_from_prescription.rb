class RemoveCurrentDosageIdFromPrescription < ActiveRecord::Migration
  def change
    remove_column :prescriptions, :current_dosage_id
  end
end
