# == Schema Information
#
# Table name: payment_holds
#
#  id         					:integer          not null, primary key
#  customer_id          :integer
#  service_contract_id  :string
#  debit 								:integer
#  credit 							:integer

#  created_at 	       :datetime
#  updated_at 	       :datetime

class PaymentHold < ActiveRecord::Base
	attr_accessible :customer_id, :service_contract_id, :debit, :credit
  belongs_to :customer
  belongs_to :service_contract
end
