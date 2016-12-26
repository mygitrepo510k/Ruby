class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.boolean :messages_email, default: true
      t.boolean :flirts_email, default: true
      t.boolean :matches_email, default: true
      t.boolean :views_email, default: true
      t.boolean :likes_email, default: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
