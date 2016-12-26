class AddPrivateIntakeToUserProgram < ActiveRecord::Migration
  def change
    add_column :user_programs, :private_intake, :boolean, default: false
  end
end
