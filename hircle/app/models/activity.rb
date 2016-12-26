class Activity < ActiveRecord::Base
  attr_accessible :activity_by_id, :activity_with_id, :company_id, :create_date, :activity_type, :department_id
  
  belongs_to :assignor, :class_name => "User", :foreign_key => "activity_by_id"
  belongs_to :assignee, :class_name => "User", :foreign_key => "activity_with_id"
  
  belongs_to :department
  belongs_to :conversation
  has_many :comments
end
