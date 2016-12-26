# == Schema Information
#
# Table name: service_requests
#
#  id         					:integer          not null, primary key
#  parked_at          	:datetime
#  departed_at      		:datetime
#  service_request_id  	integer
#  service_offer_id  		:integer
#  state  							:string

#  created_at 	       	:datetime
#  updated_at 	       	:datetime

class ServiceContract < ActiveRecord::Base
	attr_accessible :parked_at, :departed_at, :service_request_id, :service_offer_id, :state
  STATE = %w[pending noshow cancelled parked departed]
  belongs_to :service_offer
  belongs_to :service_request

  validate :state_available?, if: :state

  protected
  def state_available?
    errors.add(:state, "please select [pending, noshow, cancelled, parked, departed]") if !STATE.include?(state)
  end
end
