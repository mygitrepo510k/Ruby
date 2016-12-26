class ChangeUserIdInUserProfiles < ActiveRecord::Migration
  def change
    rename_column :user_profiles, :users_id, :user_id
  end
end
