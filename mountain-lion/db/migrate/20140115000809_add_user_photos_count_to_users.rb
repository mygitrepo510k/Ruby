class AddUserPhotosCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_photos_count, :integer, :default => 0, :null => false
  end
end
