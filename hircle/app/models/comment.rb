class Comment < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  belongs_to :activity
  
  attr_accessible :content, :conversation_id, :create_at, :user_id ,:parent_id,:activity_id
  
  belongs_to :parent, :class_name => "Comment"
  has_many :comments, :foreign_key => "parent_id"
end
