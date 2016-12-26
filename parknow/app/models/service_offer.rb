# == Schema Information
#
# Table name: service_requests
#
#  id         					:integer          not null, primary key
#  vendor_id          	:integer
#  vendor_terms_id      :integer
#  service_request_id  	:integer
#  state  							:string

#  created_at 	       	:datetime
#  updated_at 	       	:datetime

class ServiceOffer < ActiveRecord::Base
  attr_accessible :vendor_id, :vendor_terms_id, :service_request_id, :state
	STATE = %w[pending accepted refused]

  belongs_to :vendor
  belongs_to :vendor_terms
  belongs_to :service_request
  has_one :service_contract

  validate :state_available?, if: :state

  protected
  def state_available?
    errors.add(:state, "please select [pending, accepted, refused]") if !STATE.include?(state)
  end
end
