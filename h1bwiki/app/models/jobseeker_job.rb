=begin 
	Schema Info
	t.belongs_to 		:user
	t.string 				:title
	t.integer 			:transfer
	t.integer 			:status
	t.text 					:description
=end
class JobseekerJob < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :job_title, :job_description, :status, :transfer
  IMMIGRATION_STATUS = ['No Status (Not in USA)', 'OPT / CPT', 'H-1B', 'L-1 / L-2', 'H-4']
  def get_immigration_status
		IMMIGRATION_STATUS[self.status.to_i]
  end
  
  def self.search( title, city )    
    if title.present?
      all :conditions => ["lower(job_title) LIKE lower(?) OR lower(job_description) LIKE lower(?)", "%"+title+"%", "%"+title+"%"], :order => :created_at
    else
      []
    end
  end
end
