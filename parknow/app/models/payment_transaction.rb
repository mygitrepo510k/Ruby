# == Schema Information
#
# Table name: payment_holds
#
#  id         							:integer          not null, primary key
#  sender_type          		:string
#  sender_id  							:integer
#  receiver_type 						:string
#  receiver_id 							:integer
#  debit										:float
#  credit 									:float
#  transaction_foreign_id		:integer

#  created_at 	       :datetime
#  updated_at 	       :datetime

class PaymentTransaction < ActiveRecord::Base
	attr_accessible :sender_type, :sender_id, :receiver_type, :receiver_id, :debit, :credit, :transaction_foreign_id
	TYPE=%w[customer vendor system]
	
	scope :senders_customers, ->{where(sender_type: TYPE[0])}
	scope :senders_vendors, ->{where(sender_type: TYPE[1])}

	scope :receivers_customers, ->{where(receiver_type: TYPE[0])}
	scope :receivers_vendors, ->{where(receiver_type: TYPE[1])}
end
