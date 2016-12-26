class CreateDoctorPatients < ActiveRecord::Migration
  def change
    create_table :doctor_patients do |t|
      t.integer :doctor_id
      t.integer :user_id
      t.integer :state_id

      t.timestamps
    end
  end
end
