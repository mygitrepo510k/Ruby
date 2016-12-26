class CreateUserLikes < ActiveRecord::Migration
  def change
    create_table :user_likes do |t|
      t.references :user, index: true
      t.integer :visitor_id

      t.timestamps
    end
    add_index :user_likes, :visitor_id
  end
end
