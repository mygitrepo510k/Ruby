# Represents payment card data returned by the payment provider
class PaymentCard
  
  attr_reader :last4, :type, :expiry_month, :expiry_year

  def initialize(last4, type, expiry_month, expiry_year)
  end
end