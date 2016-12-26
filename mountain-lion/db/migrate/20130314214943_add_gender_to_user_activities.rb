class AddGenderToUserActivities < ActiveRecord::Migration
  def change
    add_column :user_activities, :gender, :string
    add_index :user_activities, :gender
  end
end
