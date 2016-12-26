=begin 
  Schema Info
  t.belongs_to :user
  t.string :job_title
  t.integer :job_technology
  t.integer :job_instruction
  t.string :job_placement
  t.string :job_accomodation
  t.string :job_city      #add field
  t.string :job_state     #add field
  t.string :job_duration
  t.text :job_description
=end
class PostTraining < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :job_accomodation, :job_description, :job_duration, :job_city, :job_state, :job_instruction, :job_placement, :job_technology, :job_title, :skills_attributes

  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50}
  TECH_TYPE = ['Java','Datastage']
  INSTRUCTION_MODE = ['Class Room', 'Online', 'Class Room & Online']

  def get_techtype
  	self.job_technology
  end
  def get_instruction_mode
  	INSTRUCTION_MODE[self.job_instruction.to_i]
  end  
  def self.search( title )
    all :conditions => ["job_title LIKE ? ", "%"+title+"%" ], :order => :created_at
  end
end
