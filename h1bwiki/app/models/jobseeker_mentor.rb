=begin 
	Schema Info
 	t.belongs_to :user
  t.string :title
  t.integer :support
  t.text :description
=end
class JobseekerMentor < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :job_title, :job_description, :support
  
  def self.search( title )
    #all :conditions => ["lower(title) LIKE lower(?) ", "%"+title+"%" ], :order => :created_at
    all :conditions => ["lower(job_title) LIKE lower(?) OR lower(job_description) LIKE lower(?)", "%"+title+"%", "%"+title+"%"], :order => :created_at
  end
end
