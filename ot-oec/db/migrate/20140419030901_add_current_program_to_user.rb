class AddCurrentProgramToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_program_id, :integer
  end
end
