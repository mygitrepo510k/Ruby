class AddClinicIdToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :clinic_id, :integer
  end
end
