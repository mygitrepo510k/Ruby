class CreateConversationMetadata < ActiveRecord::Migration
  def change
    create_table :conversation_metadata do |t|
      t.belongs_to :chat_conversation
      t.belongs_to :user
      t.boolean :archived, :default => false
      t.boolean :read, :default => false

      t.timestamps
    end
    add_index :conversation_metadata, :chat_conversation_id
    add_index :conversation_metadata, :user_id
  end
end
