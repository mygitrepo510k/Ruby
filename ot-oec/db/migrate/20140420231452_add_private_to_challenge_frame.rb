class AddPrivateToChallengeFrame < ActiveRecord::Migration
  def change
    add_column :challenge_frames, :private, :boolean
  end
end
