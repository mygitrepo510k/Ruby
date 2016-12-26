class ChildProfileExamSchedule
  include Mongoid::Document
  include Mongoid::Timestamps
  
  SUBJECTS=["Maths", "Science", "Hindi", "English"]
  EXAM_TYPE=["Theory-combined", "Theory-objective", "Theory-subjective", "Viva"]

  field :current_class,     type: String
  field :exam_title,        type: String
  field :subject,           type: String
  field :description,       type: String
  field :start_date,        type: Date
  field :start_time,        type: String
  field :end_time,          type: String
  field :team_exam,         type: Boolean
  field :exam_type,         type: String

  belongs_to :child_profile_exam
  
  before_save :set_time
  def set_time
    return true
  end
  validates :start_date, :start_time, :end_time, :presence => true
end
