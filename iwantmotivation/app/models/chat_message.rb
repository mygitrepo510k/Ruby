class ChatMessage < ActiveRecord::Base
  attr_accessible :body, :chat_conversation_id, :recipient_id, :sender_id, :subject

  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
end
