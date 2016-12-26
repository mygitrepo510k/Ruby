class ChildActivityOutcome
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, 						:type => String
  field :status, 						:type => String
  field :description, 			:type => String
  field :assessment_source, :type => String
  
  belongs_to :child_profile_activity
  belongs_to :assignment
  validates :title, :description, :presence => true
  def self.find_by_child_profile_activity_id cf_activity_id
  	ChildActivityOutcome.where(:child_profile_activity_id => cf_activity_id).first
  end
  
  def self.find_by_assignment_id id
    ChildActivityOutcome.where(:assignment_id => id).first
  end
end