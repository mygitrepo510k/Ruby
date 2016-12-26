class Company < ActiveRecord::Base
  attr_accessible :city, :name, :plan_id, :state, :subdomain, :website

  has_many :users
  
  has_many :departments
   

end
