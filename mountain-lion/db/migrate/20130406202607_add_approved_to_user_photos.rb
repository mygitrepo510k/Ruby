class AddApprovedToUserPhotos < ActiveRecord::Migration
  def change
    add_column :user_photos, :approved, :boolean
  end
end
