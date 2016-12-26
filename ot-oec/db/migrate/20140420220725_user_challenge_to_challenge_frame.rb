class UserChallengeToChallengeFrame < ActiveRecord::Migration
	def change
		remove_column :user_challenges, :completed
		rename_table :user_challenges, :challenge_frames
	end
end
