class UserInfo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :age, :groups_belong_to, :books_enjoyed, :city, :country, :motivational_partner, :other_groups, :philosophy_on_life, :my_story, :state, :discount_code

  validates :age, :country, :state, :presence => true
  def self.registered_country   
  	cntries = []
  	UserInfo.select("country").group("country").each do |c|
  		cntries.push([c.country,c.country])  		
  	end
  	cntries
  end
  def self.registered_state
  	states = []
  	UserInfo.select("state").group("state").each do |state|
  		states.push([state.state, state.state])
  	end
  	states
  end
  def self.registered_city
  	cities=[]
  	UserInfo.select("city").group("city").each do |cty|
  		cities.push([cty.city, cty.city])
  	end
  	cities
  end
  def self.registered_age
  	ages=[]
  	UserInfo.select("age").group("age").each do |age|
  		ages.push([age.age, age.age])
  	end
  	ages
  end
end
