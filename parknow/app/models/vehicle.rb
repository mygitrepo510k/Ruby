# == Schema Information
#
# Table name: vehicles
#
#  id         					:integer          not null, primary key
#  customer_id          :integer
#  license_plate        :integer
#  make 							  :string
#  model                :string
#  color								:string
#  created_at 	       	:datetime
#  updated_at 	       	:datetime

class Vehicle < ActiveRecord::Base
	attr_accessible :customer_id, :license_plate, :make, :model, :color
  belongs_to :customer
  has_many :service_requests
end
