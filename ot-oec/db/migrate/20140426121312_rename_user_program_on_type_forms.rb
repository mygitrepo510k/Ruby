class RenameUserProgramOnTypeForms < ActiveRecord::Migration
  def change
		rename_column :type_forms, :user_programs_id, :user_program_id
  end
end
