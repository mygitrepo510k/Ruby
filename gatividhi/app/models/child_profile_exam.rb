class ChildProfileExam
  include Mongoid::Document
  include Mongoid::Timestamps
  field :current_class,       :type=> String
  field :title,               :type=> String
  field :school_exam,         :type=> Boolean
  field :start_date,          :type=> Date
  field :end_date,            :type=> Date
  field :exam_category,       :type=> String
  field :scholarship,         :type=> Boolean
  field :date_finalised,      :type=> Boolean
  field :description,         :type=> String  

  belongs_to :family_member 
  has_many :child_profile_exam_schedules,     :dependent => :destroy
  validate :start_date, :end_date, :exam_category, :description, :presence => true
end