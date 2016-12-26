class DeleteDoctorPracticeTables < ActiveRecord::Migration
  def change
    drop_table :doctor_practices
    drop_table :practices
  end
end
