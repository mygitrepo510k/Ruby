class CreateDoctorClaims < ActiveRecord::Migration
  def change
    create_table :doctor_claims do |t|
      t.integer :user_id
      t.integer :doctor_id
      t.integer :status

      t.timestamps
    end
  end
end
