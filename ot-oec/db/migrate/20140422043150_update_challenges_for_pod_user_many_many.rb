class UpdateChallengesForPodUserManyMany < ActiveRecord::Migration
	def change
		add_column :challenges, :special, :boolean, default: false

		create_table :challenges_users, id: false do |t|
			t.integer :challenge_id
			t.integer :user_id
			t.timestamps
		end

		create_table :challenges_pods, id: false do |t|
			t.integer :challenge_id
			t.integer :pod_id
			t.timestamps
		end
	end
end
