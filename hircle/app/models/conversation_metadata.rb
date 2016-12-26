class ConversationMetadata < ActiveRecord::Base
  attr_accessible :archived, :conversation_id, :read, :user_id
  belongs_to :user
  belongs_to :conversation
  validates :conversation_id, :uniqueness => {:scope => :user_id}

end
