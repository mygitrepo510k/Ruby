class AddUniqueConstraintToUserProgram < ActiveRecord::Migration
  def change
    add_index :user_programs, [:user_id, :program_id], unique: true
  end
end
