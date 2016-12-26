class JobApplication < ActiveRecord::Base
  attr_accessible :user_id, :job_id, :watch, :like
  
  belongs_to :user
  belongs_to :job
end
