=begin 
schema info
  t.belongs_to    :user
  t.string        :job_title
  t.integer       :job_type
  t.string        :job_city        #add  2013-3-8
  t.string        :job_state       #add  2013-3-8
  t.string        :job_duration    #add  2013-3-8
  t.text          :job_description
=end  
class PostJob < ActiveRecord::Base
	attr_accessible :user_id, :job_description, :job_title, :job_type, :job_city, :job_state, :job_duration, 
                  :skills_attributes, :skill_tokens, :work_authorizations_attributes, :authors_names, :referral_amount, :duration_type, :salary, :hourly_rate
  belongs_to :user
  has_many :skills, :as => :skillable, :dependent => :destroy
  has_many :skill_lists, :through => :skills
  has_many :work_authorizations, :dependent => :destroy
  has_many :applicants
  
  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :work_authorizations, :reject_if => proc{ |a| a['workauthorization_index'] == '-1' }

  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50, :message => "Please limit length of words to less than 50 characters each."}

  attr_reader :skill_tokens
  attr_reader :authors_names
  def skill_tokens=(ids)
    self.skill_list_ids = ids.split(",")
  end
  def authors_names=(names)
    self.work_authorization_names=names
  end

  JOB_TYPE = ['Full Time','Contract','Contract to Hire']
  def get_jobtype
  	JOB_TYPE[self.job_type.to_i]
  end

  def get_skill    
    skills = ""
    self.skill_lists.each do |skill_name|
      skills += skill_name.name + " "
    end
    skills
  end

  def self.search( title, city )
    cond_text, cond_values = [], []
    if title.present?
      cond_text << "job_title LIKE ?"
      cond_values << "%#{title}%"
    end
    if city.present?
      cond_text << "job_city LIKE ?"
      cond_values << "%#{city}%"
    end
    unless cond_text.empty?      
      all :conditions => [cond_text.join(" AND "), *cond_values], :order => :created_at
    else
      all
    end
  end
=begin  
  def self.search(str)
    return [] if str.blank?
    cond_text   = str.split.map{|w| "tag_name LIKE ? "}.join(" OR ")
    cond_values = str.split.map{|w| "%#{w}%"}
    all(:conditions =>  (str ? [cond_text, *cond_values] : []))
  end
  def self.search( *args )
    return [] if args.blank?
    cond_text, cond_values = [], []
    args.each do |str|
      next if str.blank?  
      cond_text << "( %s )" % str.split.map{|w| "tag_name LIKE ? "}.join(" OR ")
      cond_values.concat(str.split.map{|w| "%#{w}%"})
    end
    all :conditions =>  [cond_text.join(" AND "), *cond_values]
  end
=end  
  def refe_amount
    ActionController::Base.helpers.number_to_currency(self.referral_amount)
  end
  def salary_amount
    ActionController::Base.helpers.number_to_currency(self.salary)
  end
  
  def hourly_amount
    ActionController::Base.helpers.number_to_currency(self.hourly_rate)
  end

  def search_postjob
    
  end

end