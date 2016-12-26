class CreateDoctorPractices < ActiveRecord::Migration
  def change
    create_table :doctor_practices do |t|
      t.integer :doctor_id
      t.integer :practice_id

      t.timestamps
    end
  end
end
