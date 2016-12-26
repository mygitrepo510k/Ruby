class CreateInternalNotifications < ActiveRecord::Migration
  def change
    create_table :internal_notifications do |t|
      t.text :message
      t.boolean :displayed, default: false

      t.timestamps
    end
  end
end
