class AddProfilePhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_photo_id, :integer
  end
end
