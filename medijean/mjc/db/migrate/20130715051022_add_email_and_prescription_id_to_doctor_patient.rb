class AddEmailAndPrescriptionIdToDoctorPatient < ActiveRecord::Migration
  def change
    add_column :doctor_patients, :email, :string
    add_column :doctor_patients, :prescription_id, :integer
  end
end
