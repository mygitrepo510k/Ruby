class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :message_thread_id
      t.timestamp :timestamp
      t.integer :sender
      t.text :msg-content

      t.timestamps
    end
  end
end
