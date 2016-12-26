class FixNotificationType < ActiveRecord::Migration
  def up
    rename_column :notifications, :type, :notification_type
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Please Do not change the notification column type, it may break the code."
  end
end
