class Feedback
  include Mongoid::Document
  field :class_name, 				type: String
  field :feedback_date, type: Date
  field :type, 					type: String
  field :from, 					type: String
  field :your_notes, 		type: String
  field :important, 		type: Boolean

  belongs_to :family_member
  validates :type, :from , :your_notes, :presence => true
end
