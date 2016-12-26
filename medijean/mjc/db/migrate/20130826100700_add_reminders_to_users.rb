class AddRemindersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :refill_reminder, :datetime
    add_column :users, :expire_reminder, :datetime
  end
end
