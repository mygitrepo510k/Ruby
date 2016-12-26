class AddFilepickerFieldsToChallengeFrame < ActiveRecord::Migration
  def change
    add_column :challenge_frames, :filepicker_url, :string
    add_column :challenge_frames, :s3_key, :string
  end
end
