class AddUserIdToPrescription < ActiveRecord::Migration
  def change
    add_column :prescriptions, :user_id, :integer
  end
end
