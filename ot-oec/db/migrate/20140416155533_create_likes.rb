class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :likeable_id
      t.string :likeable_type
      t.integer :by_id

      t.timestamps
    end
    add_index :likes, [:likeable_id, :likeable_type, :by_id], unique: true
  end
end
