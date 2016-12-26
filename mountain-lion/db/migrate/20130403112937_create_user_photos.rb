class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.string :description
      t.references :user

      t.timestamps
    end
    add_attachment :user_photos, :image
  end
end
