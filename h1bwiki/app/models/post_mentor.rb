
=begin
  Schema Info
  t.belongs_to    :user
  t.string        :job_title
  t.integer       :job_technology
  t.integer       :job_instruction
  t.string        :job_placement
  t.string        :job_accomodation
  t.string        :job_city      #add field
  t.string        :job_state     #add field
  t.string        :job_duration
  t.text          :job_description
=end
class PostMentor < ActiveRecord::Base
  belongs_to :user
  has_many :skills, :as => :skillable
  has_many :skill_lists, :through => :skills
  attr_accessible :user_id, :job_description, :job_interview, :job_title, :skills_attributes, :skill_tokens

  accepts_nested_attributes_for :skills
  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50}
  
  attr_reader :skill_tokens
  def skill_tokens=(ids)
    self.skill_list_ids = ids.split(",")
  end

  def get_skill    
    skills = ""
    self.skill_lists.each do |skill_name|
      skills += skill_name.name + " "
    end
    skills
  end
  def self.search( title )
    all :conditions => ["job_title LIKE ? ", "%"+title+"%" ], :order => :created_at
  end
end
