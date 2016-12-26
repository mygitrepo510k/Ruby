# Contains response data sent from the payment provider
class PaymentResponse

  attr_reader :success, :error_code, :message, :customer_id, :card, :charge_id

  # Constructor for PaymentResponse
  #
  # @param [Boolean] success whether the transaction was successful or not
  # @param [String] error_code the error code returned from the server
  # @param [String] message the message to be displayed to the user
  # @param [Hash] options hash, should contain one of two key-value pairs:
  #               :customer_id => the customer ID
  #               :card => the payment card details
  def initialize(success, error_code, message, options = {})
    options[:customer_id] = options[:id] unless options[:customer_id]    
    @success, @error_code, @message, @customer_id, @card, @charge_id = success, error_code, message, options[:customer_id], options[:cards], options[:charge_id]
  end

  # @return [Boolean] whether the transaction was successful
  def success?
    @success
  end
end