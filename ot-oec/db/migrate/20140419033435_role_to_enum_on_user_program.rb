class RoleToEnumOnUserProgram < ActiveRecord::Migration
	def change
		remove_column :user_programs, :role
		add_column :user_programs, :role, :integer, default: 0
	end
end
