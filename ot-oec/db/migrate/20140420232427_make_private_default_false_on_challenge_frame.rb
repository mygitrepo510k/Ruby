class MakePrivateDefaultFalseOnChallengeFrame < ActiveRecord::Migration
  def change
  	change_column :challenge_frames, :private, :boolean, default: false
  end
end
