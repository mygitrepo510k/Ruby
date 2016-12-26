# == Schema Information
#
# Table name: service_requests
#
#  id         					:integer          not null, primary key
#  customer_id          :integer
#  vehicle_id           :integer
#  latitude  						:float
#  longitude  					:float
#  expiry								:datetime
#  client_guid          :text

#  created_at 	       	:datetime
#  updated_at 	       	:datetime

class ServiceRequest < ActiveRecord::Base
	attr_accessible :customer_id, :vehicle_id, :latitude, :longitude, :expiry, :client_guid
  belongs_to :customer
  belongs_to :vehicle
  has_many :service_offers
	has_one :service_contract

  validates_uniqueness_of :client_guid
 	scope :non_expired, -> {where("expiry > '#{Time.now+2.hours}'")}

  reverse_geocoded_by :latitude, :longitude, :address => :location
	after_validation :reverse_geocode  # auto-fetch address

  def expired?

  end
end
