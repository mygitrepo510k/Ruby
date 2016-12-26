class CreateChatConversations < ActiveRecord::Migration
  def change
    create_table :chat_conversations do |t|

      t.timestamps
    end
  end
end
