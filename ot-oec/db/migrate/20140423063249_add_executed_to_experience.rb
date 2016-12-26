class AddExecutedToExperience < ActiveRecord::Migration
	def change
		add_column :challenge_frames, :executed_by_id, :integer
		add_column :challenge_frames, :executed_at, :datetime
	end
end
