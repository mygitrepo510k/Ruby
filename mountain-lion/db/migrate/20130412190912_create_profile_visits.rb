class CreateProfileVisits < ActiveRecord::Migration
  def change
    create_table :profile_visits do |t|
      t.integer :viewer_id
      t.references :user

      t.timestamps
    end
    add_index :profile_visits, :user_id
    add_index :profile_visits, [:user_id, :created_at]
  end
end
