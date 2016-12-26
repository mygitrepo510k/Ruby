# == Schema Information
#
# Table name: vendors
#
#  id         					:integer          not null, primary key
#  user_id              :integer
#  name      						:string
#  vendor_id          	:integer
#  created_at 	       	:datetime
#  updated_at 	       	:datetime

class VendorUser < ActiveRecord::Base
	attr_accessible :user_id, :name, :vendor_id
  belongs_to :user
  belongs_to :vendor
end
