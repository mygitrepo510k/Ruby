class Policy
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  field :particular, 		type: String
  field :date_paid, 		type: String
  field :amount, 				type: String
  field :description, 	type: String

  belongs_to :user
  validates :particular, :date_paid, :amount, :description, :presence => true
end
