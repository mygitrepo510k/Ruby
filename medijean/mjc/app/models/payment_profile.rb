# Represents a payment profile for a user
#
# @attr [Integer] user_id the user_id of the owner of this payment profile
# @attr [String]  customer_id the Stripe customer_id of the owner of this payment profile 
# @attr [Boolean] auto_renew whether to auto-renew prescriptions for this user
class PaymentProfile < ActiveRecord::Base
  DEFAULT_AUTO_RENEW=0

  attr_accessible :customer_id, :user_id, :auto_renew
  belongs_to :user
  before_save :default_values

  validates_presence_of :customer_id, :user_id

  private
  def default_values
    self.auto_renew ||= DEFAULT_AUTO_RENEW
  end

end
