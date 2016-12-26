# == Schema Information
#
# Table name: vendors
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  name                 :string
#  description          :text
#  latitude             :float
#  longitude            :float

#  created_at          :datetime
#  updated_at          :datetime

class Vendor < ActiveRecord::Base
	attr_accessible :user_id, :name, :description, :latitude, :longitude
  belongs_to :user
  has_many :vendor_users
  has_many :vendor_terms

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode  # auto-fetch address
end
