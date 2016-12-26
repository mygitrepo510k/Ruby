# == Schema Information
#
# Table name: customers
#
#  id         					:integer          not null, primary key
#  user_id              :integer
#  name      						:string
#  balance 							:integer
#  available_balance 		:integer

#  created_at 	       :datetime
#  updated_at 	       :datetime

class Customer < ActiveRecord::Base
	validates_presence_of :user_id
	attr_accessible :name, :balance, :available_balance, :user_id
	belongs_to :user
	has_many :vehicles
	has_many :service_requests

	has_many :payment_holds
	
	def service_offers
		request_ids = self.service_requests.map(&:id) 
		ServiceOffer.where(id:request_ids)
	end
	def service_contracts
		request_ids = self.service_requests.map(&:id) 
		ServiceContract.where(id:request_ids)
	end
end
