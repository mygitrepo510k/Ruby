class FixManyManyChallengeUserProgram < ActiveRecord::Migration
	def change
		drop_table :challenges_users

		create_table :challenges_user_programs, id: false do |t|
			t.integer :challenge_id
			t.integer :user_programs_id
			t.timestamps
		end
	end
end
