require 'spec_helper'

describe OrdersController do 

  context "#index" do
    context "authorization" do
      before { get :index }
      it { should redirect_to new_user_session_path }
    end
  end

  describe "POST create" do
    let(:user) { FactoryGirl.create(:user) }
    let(:prescription) { FactoryGirl.create(:prescription, user: user) }
    let(:order) { FactoryGirl.build(:order, prescription: prescription, user: user) }
    
    before { sign_in(user) }

    context "with valid data" do
      it "places an order when shipping address is NOT the same as billing address, saving they payment method and auto renewing " do
        card_token = Stripe::Token.create(card: {number: '4242424242424242', exp_month: '5', exp_year: '2014'})
        post :create, { :prescription_id=>order.prescription.id,
          :stripe_card_token=>card_token.id,
          :order=>order.attributes.except("processed_by_id","tracking_number","payment_status","id","created_at","updated_at","status").merge(:status=>:placed),
          :shipping_address=>order.shipping_address.attributes.except('id','created_at','updated_at','country_id','immutable','addressable_type','addressable_id'),
          :paymentprofile=>{:auto_renew=>"0"},:save_payment=>"0"}
        response.should redirect_to(complete_orders_path)
      end

      it "places an order when shipping address is the same as billing address, saving they payment method and auto renewing " do
        card_token = Stripe::Token.create(card: {number: '4242424242424242', exp_month: '5', exp_year: '2014'})
        post :create, { :prescription_id=>order.prescription.id,
          :stripe_card_token=>card_token.id,
          :order=>order.attributes.except("processed_by_id","tracking_number","payment_status","id","created_at","updated_at","status").merge(:status=>:placed),
          :address=>order.shipping_address.attributes.except('id','created_at','updated_at','country_id','immutable','addressable_type','addressable_id'),
          :paymentprofile=>{:auto_renew=>"0"},:save_payment=>"0",:shipping_check=>"0"}
        response.should redirect_to(complete_orders_path)
      end

      it "places an order when shipping address is the same as billing address, NOT saving the payment method and NO auto renewing" do
        card_token = Stripe::Token.create(card: {number: '4242424242424242', exp_month: '5', exp_year: '2014'})
        post :create, { :prescription_id=>order.prescription.id,
          :stripe_card_token=>card_token.id,
          :order=>order.attributes.except("processed_by_id","tracking_number","payment_status","id","created_at","updated_at","status").merge(:status=>:placed),
          :address=>order.shipping_address.attributes.except('id','created_at','updated_at','country_id','immutable','addressable_type','addressable_id'),
          :shipping_check=>"0"}
        response.should redirect_to(complete_orders_path)
      end

      it "places an order when shipping address is the same as billing address, saving the payment method but NO auto renewing" do
        card_token = Stripe::Token.create(card: {number: '4242424242424242', exp_month: '5', exp_year: '2014'})
        post :create, { :prescription_id=>order.prescription.id,
          :stripe_card_token=>card_token.id,
          :order=>order.attributes.except("processed_by_id","tracking_number","payment_status","id","created_at","updated_at","status").merge(:status=>:placed),
          :address=>order.shipping_address.attributes.except('id','created_at','updated_at','country_id','immutable','addressable_type','addressable_id'),
          :shipping_check=>"0",:save_payment=>"0"}
        response.should redirect_to(complete_orders_path)
      end

    end

    context "with in-valid data" do
    #When Street and City is not present and postal address is invalid.
      it "renders new template when data is invalid" do
        card_token = Stripe::Token.create(card: {number: '4242424242424242', exp_month: '5', exp_year: '2014'})
        post :create, { :prescription_id=>order.prescription.id,
          :stripe_card_token=>card_token.id,
          :order=>order.attributes.except("processed_by_id","tracking_number","payment_status","id","created_at","updated_at","status").merge(:status=>:placed),
          :shipping_address=>order.shipping_address.attributes.except('id','created_at','updated_at','country_id','immutable','addressable_type','addressable_id','city','street','postal_code').merge(:postal_code=>'123'),
          :paymentprofile=>{:auto_renew=>"0"},:save_payment=>"0"}
        response.should render_template("new")
      end
    end
  end
end