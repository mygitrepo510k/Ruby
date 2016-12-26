# Acts as an interface between the system and the payment processor
class PaymentProvider
  CURRENCY = "cad"

  # Authorizes the payment against the user's card. 
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#create_charge
  # 
  # @param [BigDecimal] amount the amount to authorize for
  # @param [String] description the description of the transaction
  # @param [Hash] options hash, should contain one of two key-value pairs:
  #               :token => the token representing the card
  #               :customer_id => the Stripe customer ID of the user
  # @return [PaymentResponse] the response from the server
  def authorize(amount, description, options = {})
    begin
      charge = Stripe::Charge.create(amount: amount, currency: CURRENCY, card: options[:token],customer: options[:customer_id], description: description)
      unless charge.failure_code
        PaymentResponse.new(true, nil, nil, {:charge_id=>charge.id,:customer_id=>options[:customer_id]})
      else
        PaymentResponse.new(false, charge.failure_code, charge.failure_message, options)
      end
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message, options)
    end
  end

  # Completes an already-authorized transaction
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#charge_capture
  #
  # @param [String] charge_id the Stripe charge ID
  # @return [PaymentResponse] the response from the server
  def capture(charge_id)
    begin
      charge = Stripe::Charge.retrieve(charge_id)
      charge.capture
      unless charge.failure_code
        PaymentResponse.new(true, nil, nil)
      else
        PaymentResponse.new(false, charge.failure_code, charge.failure_message)
      end
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message)
    end
  end

  # Charges a credit card
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#create_charge
  #
  # @param [BigDecimal] amount the amount to authorize for
  # @param [String] description the description of the transaction
  # @param [Hash] options hash, should contain one of two key-value pairs:
  #               :card => the token representing the card
  #               :customer_id => the Stripe customer ID of the user
  # @return [PaymentResponse] the response from the server
  def charge(amount, description, options = {})
    begin
      charge = Stripe::Charge.create(amount: amount, currency: CURRENCY, card: options[:token],customer: options[:customer_id], description: description)
      unless charge.failure_code
        PaymentResponse.new(true, nil, nil, {:charge_id=>charge.id,:customer_id=>options[:customer_id]})
      else
        PaymentResponse.new(false, charge.failure_code, charge.failure_message, options)
      end
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message, options)
    end
  end

  # Refunds an existing transaction
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#refund_charge
  #
  # @param [String] charge_id the Stripe charge ID
  # @return [PaymentResponse] the response from the server
  def refund(charge_id)
    begin
      charge = Stripe::Charge.retrieve(charge_id)
      charge.refund
      unless charge.failure_code
        PaymentResponse.new(true, nil, nil)
      else
        PaymentResponse.new(false, charge.failure_code, charge.failure_message)
      end
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message)
    end
  end

  # Creates a customer object in Stripe
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#create_customer
  #
  # @param [String] token the token representing the card
  # @param [String] description the description of the profile
  # @return [PaymentResponse] the response containing the customer ID
  def create_profile(token, description, email)
    begin
      customer = Stripe::Customer.create(card: token, description: description, email: email)
      PaymentResponse.new(true, nil, nil,{:customer_id=>customer.id, :cards=>customer.cards})
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message)
    end
  end

  # Retrieve a customer object in Stripe
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#retrieve_customer
  #
  # @param [String] customer_id the customer ID of the user
  # @return [PaymentResponse]
  def get_profile(customer_id)
    begin
      customer = Stripe::Customer.retrieve(customer_id)      
      PaymentResponse.new(true, nil, nil, customer)
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message)
    end
  end
  
  # Deletes a customer's profile from Stripe
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#delete_customer
  #
  # @param [String] customer_id the customer ID of the user
  # @return [PaymentResponse]
  def delete_profile(customer_id)
    begin
      customer = Stripe::Customer.retrieve(customer_id)
      customer.delete
      PaymentResponse.new(true, nil, nil, customer)
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message)
    end
  end
  # Updates the customer's profile in Stripe
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#update_customer
  #
  # @param [String] customer_id the customer ID
  # @param [String] token the token representing the new card to activate on the profile
  # @param [String] description the description of the profile
  # @return [PaymentResponse]
  def update_profile(customer_id, token, description)
    begin
      customer = Stripe::Customer.retrieve(customer_id)
      customer.description = description
      customer.card = token
      customer.save
      PaymentResponse.new(true, nil, nil, customer)
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message)
    end
  end

  def retrieve_profile(customer_id)
    begin
      customer = Stripe::Customer.retrieve(customer_id)
      PaymentResponse.new(true, nil, nil,{:customer_id=>customer.id})
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message, nil)
    end
  end

  # Retrieves customer's card
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#retrieve_card
  #
  # @param [String] customer_id the customer ID
  # @return [PaymentResponse] payment response with PaymentCard filled in for card details
  def retrieve_card(customer_id)
    begin
      customer = Stripe::Customer.retrieve(customer_id)
      card = customer.cards
      PaymentResponse.new(true, nil, nil, customer_id: customer_id, card: card)
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message)
    end
  end

  # Updates the card on Stripe. Two things can be updated, expiry or billing address
  # If there is no need to update a field, pass it as null
  # Implementation based on: https://stripe.com/docs/api?lang=ruby#update_card
  # 
  # @param [String] customer_id the customer ID
  # @param [String] expiry_month the new expiry month
  # @param [String] expiry_year the new expiry year
  # @param [Address] billing_address the new billing address
  # @return [PaymentResponse]
  def update_card(customer_id, expiry_month, expiry_year, billing_address)
    begin
      customer = Stripe::Customer.retrieve(customer_id)
      card = customer.cards.first
      card.exp_month = expiry_month
      card.exp_year = expiry_year
      card.address_city = billing_address.city
      card.address_country = billing_address.country.try(:name)
      card.address_line1 = billing_address.street
      card.address_zip = billing_address.postal_code
      card.save
      PaymentResponse.new(true, nil, nil, customer_id: customer_id, card: card)
    rescue Stripe::InvalidRequestError => e
      PaymentResponse.new(false, nil, e.message, customer_id: customer_id)
    end 
  end
end