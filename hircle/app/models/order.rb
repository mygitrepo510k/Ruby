class Order < ActiveRecord::Base
  attr_accessible :card_expires_on, :card_number, :card_type, :card_verification, :first_name, :ip_address, :last_name
  attr_accessor :card_number,:card_verification
  validate(:validate_card,:on=>:create)

  def purchase(shared_value)
    value=shared_value.to_f
    value=value*100

    response=GATEWAY.purchase(Integer(value),credit_card,:ip=> ip_address, :billing_address=> {:name=>"john M.V",:address1=>"Muttath",:city=>"Thrissur",:state=>"Kerala",:country=>"IN",:ZIP=>"680505"})
    response.success?
  end

  private

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message  |
        errors[:base] << message

      end
    end
  end

  def credit_card
    @credit_card||= ActiveMerchant::Billing::CreditCard.new(
        :type=> card_type,
        :number=>card_number,
        :verification_value=>card_verification,
        :month=>card_expires_on.month,
        :year=>card_expires_on.year,
        :first_name=>first_name,
        :last_name=>last_name
    )
  end
end
