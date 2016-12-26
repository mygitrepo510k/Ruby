class Department < ActiveRecord::Base
  attr_accessible :company_id, :description, :name
  belongs_to :company
  has_many :users
  has_many :tasks  
  has_many :resources
  
end
