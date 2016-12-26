class SchoolCl
  include Mongoid::Document
  field :name,              type: String
  field :current_class, 		type: Boolean
  field :start_date, 				type: Date
  field :end_date, 					type: Date  
  field :section, 					type: String
  field :roll_number, 			type: String
  field :class_teacher, 		type: String

  belongs_to :school
end
