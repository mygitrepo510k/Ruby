class FixColumnNameForChallengeUserPrograms < ActiveRecord::Migration
	def change
		rename_column :challenges_user_programs, :user_programs_id, :user_program_id
	end
end
