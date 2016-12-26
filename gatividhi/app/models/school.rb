class School
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name,                type: String
  field :current_school,      type: Boolean
  field :start_date,          type: Date
  field :end_date,            type: Date
  field :country,             type: String
  field :state,               type: String
  field :city,                type: String  
  field :enrolment_number,    type: String
  field :board,               type: String
  field :house,               type: String
  field :medium,              type: String
  field :category,            type: String
  field :type,                type: String
  field :school_principle,    type: String
  field :child_advisor,       type: String

  belongs_to :family_member
  has_many :school_cls,         :dependent => :destroy
  has_many :school_subjects,    :dependent => :destroy

end
