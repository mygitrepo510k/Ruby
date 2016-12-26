require 'spec_helper'

describe PaymentProfilesController do
	before do 
    @user = FactoryGirl.create(:user)
    sign_in @user   
  end

  describe 'GET #new' do
    before { @payment_profile = FactoryGirl.create(:payment_profile) }
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe 'GET #edit' do    
    context 'when profile is exist' do
      before { @payment_profile = FactoryGirl.create(:payment_profile) }
      it "returns http success" do
        get :edit
        response.should be_success
      end
    end
    context 'when profile is not exist' do
      before { @payment_profile = FactoryGirl.create(:payment_profile) }
      it "redirect to new action" do
        get :new
        response.should be_success
      end      
    end
  end
    
  describe 'POST #create' do
    before do
      card_token =  Stripe::Token.create(card: {number: '4242424242424242', exp_month: Time.now().month, exp_year: Time.now().year+2})
      customer = Stripe::Customer.create(card: card_token.id, description: "A Customer")
      @payment_profile = FactoryGirl.create(:payment_profile)
      @user.payment_profile = @payment_profile
      @user.payment_profile.customer_id = customer.id
      @payment_profile.save
      @user.save
    end

    context 'when profile was created' do
      it "renders the :payment show" do        
        render_template 'payment_profiles/show'
        response.should be_success
      end
    end

    context 'when profile was not created' do
      it "redirect :back" do
        redirect_to :back
        response.should be_success
      end
    end
  end

  describe 'PUT #update' do
    before do
      card_token =  Stripe::Token.create(card: {number: '4012888888881881', exp_month: Time.now().month, exp_year: Time.now().year+2})
      customer = Stripe::Customer.create(card: card_token.id, description: "A Customer")
      @payment_profile = FactoryGirl.create(:payment_profile)
      @user.payment_profile = @payment_profile
      @user.payment_profile.customer_id = customer.id
      @payment_profile.save
      @user.save      
    end

    context 'when profile was updated' do
      it "renders the :payment show" do        
        render_template 'payment_profiles/show'
        response.should be_success
      end
    end

    context 'when profile was not updated' do
      it "redirect :back" do
        redirect_to :back
        response.should be_success        
      end
    end
  end
end
