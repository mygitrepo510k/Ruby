class CreateConversationMetadata < ActiveRecord::Migration
  def change
    create_table :conversation_metadata do |t|
      t.belongs_to :conversations
      t.belongs_to :user
      t.boolean :archived, :default => false
      t.boolean :read, :default => false

      t.timestamps
    end
    add_index :conversation_metadata, :conversations_id
    add_index :conversation_metadata, :user_id
  end
end
