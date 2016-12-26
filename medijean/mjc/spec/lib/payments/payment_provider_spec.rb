require 'spec_helper'

# TODO: Stub API requests instead of making real calls

describe PaymentProvider do


  let(:card_token) { Stripe::Token.create(card: {number: '4242424242424242', exp_month: '5', exp_year: '2014'}) }
  let(:customer) { Stripe::Customer.create(:description=>'A customer',:email=>'test@medijean.com',:card=>card_token.id) }
  let(:payment_provider) { PaymentProvider.new }
  let(:charge){ Stripe::Charge.create(amount: 500, currency: PaymentProvider::CURRENCY, card: card_token.id, description: 'Charge for test@medijean.com', capture: false) }

  describe "#authorize" do
    subject{ payment_provider.authorize(500, 'Charge for test@medijean.com', token: card_token.card.id, customer_id: customer.id) }
    it { should be_a_kind_of(PaymentResponse) }
    its(:customer_id) { should eq customer.id }

    context "when request is successful" do
      its(:success?) { should be_true }
    end

    context "when request is invalid" do
      context "when token is already used" do
        before { payment_provider.create_profile( card_token.id, 'Charge for test@medijean.com', 'test@medijean.com') }
        subject { payment_provider.authorize(500, 'Charge for test@medijean.com', token: card_token.id) }
        its(:success?) { should be_false }
        its(:message) { should eq "You cannot use a Stripe token more than once: #{card_token.id}" }
      end
    end

  end

  describe "#capture" do
    subject { payment_provider.capture(charge.id) }

    it { should be_a_kind_of(PaymentResponse) }
    it "retrieves charge with given charge id" do
      Stripe::Charge.should_receive(:retrieve).with(charge.id) { charge }
      subject
    end

    context "when request is successful" do
      its(:success?) { should be_true }
    end

    context "when request is invalid" do
      context "when charge has already been captured" do
        before { charge.capture }
        its(:success?) { should be_false }
        its(:message) { should eq "Charge #{charge.id} has already been captured." }
      end
    end

  end

  describe "#charge" do
    subject{ payment_provider.charge(500, 'Charge for test@medijean.com', token: card_token.card.id, customer_id: customer.id) }
    it { should be_a_kind_of(PaymentResponse) }
    its(:customer_id) { should eq customer.id }

    context "when request is successful" do
      its(:success?) { should be_true }
    end

    context "when request is invalid" do
      context "when token is already used" do
        before { payment_provider.create_profile( card_token.id, 'Charge for test@medijean.com', 'test@medijean.com') }
        subject { payment_provider.charge(500, 'Charge for test@medijean.com', token: card_token.id) }
        its(:success?) { should be_false }
        its(:message) { should eq "You cannot use a Stripe token more than once: #{card_token.id}" }
      end
    end

  end

  describe "#refund" do
    before { charge.capture }
    subject { payment_provider.refund(charge.id) }

    it { should be_a_kind_of(PaymentResponse) }
    it "retrieves charge with given charge id" do
      Stripe::Charge.should_receive(:retrieve).with(charge.id) { charge }
      subject
    end

    context "when request is successful" do
      its(:success?) { should be_true }
    end

    context "when request is invalid" do
      context "when charge has already been refunded" do
        before { payment_provider.refund(charge.id) }
        its(:success?) { should be_false }
        its(:message) { should eq "Charge #{charge.id} has already been refunded." }
      end
    end
  end

  describe "#create_profile" do
    subject { payment_provider.create_profile(card_token.id, "Profile of test@medijean.com", "test@medijean.com") }

    it { should be_a_kind_of(PaymentResponse) }

    context "when request is successful" do
      its(:success?) { should be_true }
    end

    context "when request is invalid" do
      context "when profile has already been created" do
        before { payment_provider.create_profile(card_token.id, "Profile of test@medijean.com", "test@medijean.com") }
        its(:success?) { should be_false }
        its(:message) { should eq "You cannot use a Stripe token more than once: #{card_token.id}" }
      end
    end

  end

  describe "#delete_profile" do
    before { customer }
    subject { payment_provider.delete_profile(customer.id) }

    it { should be_a_kind_of(PaymentResponse) }

    context "when request is successful" do
      its(:success?) { should be_true }
    end

    context "when request is invalid" do
      context "when profile has already been deleted" do
        before { payment_provider.delete_profile(customer.id) }
        its(:success?) { should be_false }
        its(:message) { should eq "No such customer: #{customer.id}" }
      end
    end
    
  end

  describe "#update_profile" do
    before { customer }
    let(:next_token) { Stripe::Token.create(card: {number: '4242424242424242', exp_month: '5', exp_year: '2014'}) }
    subject { payment_provider.update_profile(customer.id, next_token.id, "Update Profile") }

    it { should be_a_kind_of(PaymentResponse) }

    context "when request is successful" do
      its(:success?) { should be_true }
    end
  
  end

  describe "#retrieve_card" do
    subject{ payment_provider.retrieve_card(customer.id) }
    it { should be_a_kind_of(PaymentResponse) }

    #context "when request is successful" do
    #  its(:card) { should_not be_nil }
    #  its(:success?) { should be_true }
    #end

    context "when request is invalid" do
      context "when customer not found with supplied customer_id" do
        subject{ payment_provider.retrieve_card("ABCDE") }
        its(:card) { should be_nil }
        its(:success?) { should be_false }
      end
    end
  end

  describe "#update_card" do
    let(:address) { FactoryGirl.build(:address) }
    let(:response) { payment_provider.update_card(customer.id, "05", "2020", address ) }
    subject { response }
    it { should be_a_kind_of(PaymentResponse) }
=begin    
    context "when request is successful" do
      its(:card) { should_not be_nil }
      its(:success?) { should be_true }
      describe "#card" do
        subject{ response.card }
        its(:exp_month) { should eq 5 }
        its(:exp_year) { should eq 2020 }
        its(:address_city) { should eq address.city}
        its(:address_country) { should eq address.country.name}
        its(:address_line1) { should eq address.street}
        its(:address_zip) { should eq address.postal_code}
      end
    end
=end
    context "when request is invalid" do
      context "when customer not found with supplied customer_id" do
        subject{ payment_provider.retrieve_card("ABCDE") }
        its(:card) { should be_nil }
        its(:success?) { should be_false }
        its(:message) { should eq "No such customer: ABCDE" }
      end
    end
  end

end