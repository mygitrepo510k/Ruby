class ChatConversation < ActiveRecord::Base
  has_many :chat_messages, :order => "created_at"
  has_many :conversation_metadata, :dependent => :destroy
    
  
  scope :for_user, lambda { |user|
    joins(:conversation_metadata).
        includes(:chat_messages).
        where("conversation_metadata.user_id = ?", user.id).
        order("messages.updated_at DESC")
  }

  # at least one chat_messages in the conversation was sent to user
  scope :for_recipient, lambda { |user|
    joins(:conversation_metadata).
        includes(:chat_messages).
        where("conversation_metadata.user_id = ? AND messages.recipient_id = ?", user.id, user.id)
  }

  scope :archived?, lambda { |is_archived|
    joins(:conversation_metadata).
        where("conversation_metadata.archived = ?", is_archived)
  }

  scope :read?, lambda { |is_read|
    joins(:conversation_metadata).
        where("conversation_metadata.read = ?", is_read)
  }


  accepts_nested_attributes_for :chat_messages
  # attr_accessible :chat_messages_attributes
end
