class AddContentGroupToChallengeFrame < ActiveRecord::Migration
  def change
    add_column :challenge_frames, :content_group_id, :integer
  end
end
