class Message < ActiveRecord::Base
  attr_accessible :message_thread_id, :msg-content, :sender, :timestamp
end
