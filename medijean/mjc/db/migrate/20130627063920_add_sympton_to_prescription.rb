class AddSymptonToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :sympton, :string
  end
end
