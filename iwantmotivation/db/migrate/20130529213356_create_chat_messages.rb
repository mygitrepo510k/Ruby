class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.text :body
      t.string :subject
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :chat_conversation_id
      t.timestamps
    end
  end
end
