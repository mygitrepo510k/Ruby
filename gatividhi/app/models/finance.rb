class Finance
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  field :income, 					type: String
  field :disable_income, 	type: String
  field :school_free, 		type: String
  field :child_expense, 	type: String

  belongs_to :user
  has_many :advances_paids, 				:dependent => :destroy
  has_many :child_related_policies, 	:dependent => :destroy
end
