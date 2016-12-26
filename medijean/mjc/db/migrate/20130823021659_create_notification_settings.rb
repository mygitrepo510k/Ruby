class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.belongs_to :user
      t.boolean :receive_message
      t.boolean :has_news
      t.boolean :has_tagged_me
      t.boolean :receive_prescription

      t.timestamps
    end
    add_index :notification_settings, :user_id
  end
end
