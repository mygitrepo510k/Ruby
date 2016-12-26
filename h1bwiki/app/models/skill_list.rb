class SkillList < ActiveRecord::Base
  attr_accessible :name
  has_many :skill, :as => :skillable
  has_many :post_jobs, :through => :skillable
  has_many :post_mentors, :through => :skillable
end
