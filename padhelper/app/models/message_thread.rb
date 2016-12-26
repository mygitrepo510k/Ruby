class MessageThread < ActiveRecord::Base
  attr_accessible :thread_helper, :thread_user, :user_id
end
