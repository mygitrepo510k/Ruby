class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.references :user
      t.string :activity_type

      t.timestamps
    end
    add_index :user_activities, :user_id
  end
end
