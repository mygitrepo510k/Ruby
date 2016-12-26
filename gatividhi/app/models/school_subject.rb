class SchoolSubject
  include Mongoid::Document
  field :subject, type: String
  belongs_to :school_cl
end
