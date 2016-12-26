class ChangeDoctorPatientsStatusDefault < ActiveRecord::Migration
  def up
    change_column_default(:doctor_patients, :status, 0)
  end

  def down
    change_column_default(:doctor_patients, :status, nil)
  end
end
