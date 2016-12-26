class Message < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :recipient_id, :sender_id, :subject
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
end
