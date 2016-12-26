class AddRedYellowGreenToUserProgram < ActiveRecord::Migration
  def change
    add_column :user_programs, :safeword, :integer, default: 0
  end
end
