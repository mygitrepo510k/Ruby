
# == Schema Information
#
# Table name: vendors
#
#  id                   :Integer          not null, primary key
#  sender_id            :Integer
#  recipient_email      :String
#  token          			:String
#  sent_at             	:Datetime

#  created_at          	:Datetime
#  updated_at          	:Datetime

class Invitation < ActiveRecord::Base
	attr_accessible :sender_id, :recipient_email, :token, :sent_at
	STATE = %w[pending accepted revoked]
	belongs_to :sender, :class_name => 'User'
	has_one :recipient, :class_name => 'User'

	validates_presence_of :recipient_email
	validate :recipient_is_not_registered
	validate :sender_has_invitations, :if => :sender

	before_create :generate_token
	before_create :decrement_sender_count, :if => :sender

	scope :pending_invitations, -> {where(state:STATE[0])}
	scope :accepted_invitations, -> {where(state:STATE[0])}
	

	private
	def recipient_is_not_registered
		errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
	end

	def sender_has_invitations
		#unless sender.invitation_limit > 5
		#	errors.add(:limit, 'You have reached your limit of invitiations to send.') 
		#end
	end

	def generate_token
		self.token=Digest::SHA1.hexdigest([Time.now,rand].join)
	end

	def decrement_sender_count
		sender.decrement! :invitation_limit
	end	
end
