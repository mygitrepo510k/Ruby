class Teacher
  include Mongoid::Document
  field :name, 						type: String
  field :position, 				type: String
  field :email, 					type: String
  field :phone_number, 		type: String
  field :other_details, 	type: String

  belongs_to :family_member
  validates :name, :position, :presence => true
end
