class MajorIllness
  include Mongoid::Document
  include Mongoid::Timestamps
  field :health_issue, 		:type=> String
  field :start_date, 			:type=> Date
  field :end_date, 				:type=> Date
  field :details, 				:type=> String
  
  validates :health_issue, :start_date, :end_date, :details, presence: true

  belongs_to :family_member 
end
