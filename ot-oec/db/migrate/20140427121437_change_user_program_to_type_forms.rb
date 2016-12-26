class ChangeUserProgramToTypeForms < ActiveRecord::Migration
	def change
		remove_column :type_forms, :user_program_id
		add_column :type_forms, :user_id, :integer, index: true
		add_column :type_forms, :program_id, :integer, index: true
	end
end
