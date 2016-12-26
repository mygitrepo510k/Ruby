# == Schema Information
#
# Table name: vendor_terms
#
#  id         					:integer          not null, primary key
#  vendor_id            :integer
#  enabled      				:boolean
#  hourly_rate          :float
#  max_hourly_hours 		:float
#  flat_rate 						:float
#  max_flat_hours				:float

#  created_at 	       :datetime
#  updated_at 	       :datetime
class VendorTerm < ActiveRecord::Base
	attr_accessible :vendor_id, :enabled, :hourly_rate, :max_hourly_hours, :flat_rate, :max_flat_hours
  belongs_to :vendor

  scope :enabled_temrs, ->{where(:enabled => true)}

end
