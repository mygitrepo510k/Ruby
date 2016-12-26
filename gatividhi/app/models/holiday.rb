class Holiday
  include Mongoid::Document
  field :class_name, 			type: String
  field :title, 					type: String
  field :start_date, 			type: Date
  field :end_date, 				type: Date
  field :type, 						type: String
  field :description, 		type: String
  field :date_finalised, 	type: Boolean

  belongs_to :family_member
  validates :title, :start_date, :end_date, :type, :description, :presence => true
end
