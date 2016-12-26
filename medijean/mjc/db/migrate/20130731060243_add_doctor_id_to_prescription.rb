class AddDoctorIdToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :doctor_id, :integer
  end
end
