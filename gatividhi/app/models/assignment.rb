class Assignment
  include Mongoid::Document
  field :class_name,    type: String
  field :title,         type: String
  field :category,      type: String
  field :subject,       type: String
  field :due_date,      type: Date
  field :due_time,      type: Time
  field :description,   type: String
  field :to_be_graded,  type: Boolean
  field :outcome,       type: String

  validates :class_name, :title, :category, :subject, :due_date, :description, :presence => true

  belongs_to :family_member
  has_many :child_activity_outcomes,  :dependent => :destroy 
end
