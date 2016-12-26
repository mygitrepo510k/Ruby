require 'abstract_base_model'

class Pod < SoftDeletedModel
  belongs_to :leader, class_name: 'User'
  belongs_to :program

  has_many :user_programs
  has_many :users, through: :user_programs

	has_and_belongs_to_many :challenges

  attr_accessible :name, :avatar, :leader, :program
end
