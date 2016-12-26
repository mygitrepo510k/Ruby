class AddThumbnailUrlToChallengeFrame < ActiveRecord::Migration
  def change
    add_column :challenge_frames, :thumbnail_url, :string
  end
end
