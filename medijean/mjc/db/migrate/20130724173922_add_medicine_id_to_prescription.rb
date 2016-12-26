class AddMedicineIdToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :medicine_id, :integer
  end
end
