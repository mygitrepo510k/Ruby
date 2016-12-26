class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.references :user, index: true
      t.time :likes_viewed_at
      t.time :views_viewed_at

      t.timestamps
    end
  end
end
