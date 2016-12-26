class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.belongs_to :user
      t.belongs_to :friend
      t.string :channel
      t.timestamps
    end
    add_index :friends, :user_id
  end
end
