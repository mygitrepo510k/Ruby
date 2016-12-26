class ChangeUserLog < ActiveRecord::Migration
  def change
    remove_column :user_logs, :likes_viewed_at
    add_column :user_logs, :likes_viewed_at, :datetime
    remove_column :user_logs, :views_viewed_at
    add_column :user_logs, :views_viewed_at, :datetime
  end
end
