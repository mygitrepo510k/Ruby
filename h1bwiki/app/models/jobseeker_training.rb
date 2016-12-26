=begin
  t.belongs_to :user
  t.string :title
  t.integer :status
  t.integer :transfer
  t.string :technology
  t.integer :instruction_mod
  t.integer :accomodation
  t.text :description
=end
class JobseekerTraining < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :job_title, :job_description, :accomodation, :instruction_mod, :status, :technology, :transfer

  IMMIGRATION_STATUS = ['No Status (Not in USA)', 'OPT / CPT', 'H-1B', 'L-1 / L-2', 'H-4']
  INSTRUCTION_MODE=['Class Room', 'Online', 'Class Room & Online']
  def get_immigration_status
		IMMIGRATION_STATUS[self.status.to_i]
  end
  def get_instruction_mode
  	INSTRUCTION_MODE[self.instruction_mod.to_i]
  end
  def self.search( title )
    #all :conditions => ["job_title LIKE ? ", "%"+title+"%" ], :order => :created_at
    all :conditions => ["lower(job_title) LIKE lower(?) OR lower(job_description) LIKE lower(?)", "%"+title+"%", "%"+title+"%"], :order => :created_at
  end
end
