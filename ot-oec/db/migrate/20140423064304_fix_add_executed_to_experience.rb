class FixAddExecutedToExperience < ActiveRecord::Migration
  def change
		remove_column :challenge_frames, :executed_by_id
		remove_column :challenge_frames, :executed_at
  end
end
