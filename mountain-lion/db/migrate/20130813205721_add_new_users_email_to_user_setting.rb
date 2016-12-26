class AddNewUsersEmailToUserSetting < ActiveRecord::Migration
  def change
    add_column :user_settings, :new_users_email, :boolean, default: true
  end
end
