class ReverseAssociationBetweenDoctorPatientsAndPrescriptions < ActiveRecord::Migration
  def up
    add_column :prescriptions, :doctor_patient_id, :integer
    remove_column :doctor_patients, :prescription_id
  end

  def down
    add_column :doctor_patients, :prescription_id, :integer
    remove_column :prescriptions, :doctor_patient_id
  end
end
