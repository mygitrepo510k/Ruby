class AddFilepickerFieldsToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :thumbnail_url, :string
    add_column :challenges, :filepicker_url, :string
  end
end
