class CreateMessageThreads < ActiveRecord::Migration
  def change
    create_table :message_threads do |t|
      t.integer :user_id
      t.integer :thread_user
      t.integer :thread_helper

      t.timestamps
    end
  end
end
