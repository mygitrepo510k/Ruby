class TypeForm < ActiveRecord::Base
  belongs_to :program
  belongs_to :user
	
	attr_accessible :form, :response, :user, :program, :response_id, :user_id
end
