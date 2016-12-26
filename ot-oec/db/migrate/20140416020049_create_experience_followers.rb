class CreateExperienceFollowers < ActiveRecord::Migration
  def change
    create_table :experience_followers do |t|
      t.belongs_to :user
      t.belongs_to :experience

      t.timestamps
    end
    add_index :experience_followers, [:user_id, :experience_id], unique: true
  end
end
