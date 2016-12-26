# Represents a payment transaction
#
# @attr [String] message the message to display to the user. Only required when the transaction failed
# @attr [Boolean] success whether the transaction was successful or not
class Payment < ActiveRecord::Base
  enum_field :operation, { authorize: 0, capture: 1, charge: 2, refund: 3 }

  attr_accessible :charge_id, :message, :operation, :order_id, :success

  belongs_to :order

  validates_presence_of :operation, :order, :charge_id, :success
  validates_presence_of :message, :if => :failed?

  def failed?
    !self.success
  end
end
