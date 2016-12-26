class Space < ActiveRecord::Base

  attr_accessible :company_id, :creator_id, :company_id, :description, :name,:status,:id

  belongs_to :company

   has_and_belongs_to_many  :user
   
end