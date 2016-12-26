class Assignment < ActiveRecord::Base
  attr_accessible :assignee_id, :task_id
  belongs_to :assignee , :class_name => "User",:foreign_key => "user_id"
  belongs_to :task
end
