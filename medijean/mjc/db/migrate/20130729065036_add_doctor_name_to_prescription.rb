class AddDoctorNameToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :doctor_name, :string
    add_column :prescriptions, :issue_date, :date
  end
end
