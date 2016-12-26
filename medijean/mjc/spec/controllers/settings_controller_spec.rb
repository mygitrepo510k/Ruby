require 'spec_helper'

describe SettingsController do
  
  before do 
    @user = FactoryGirl.create(:user)
    sign_in @user   
  end

  describe "GET '/settings/profile'" do
    context "with the patient" do
      it "renders the :profile eidt" do
        render_template 'profiles/edit'
      end
    end
    context "with the doctor" do
      it "renders the :doctors edit" do
        render_template 'doctors/edit'
      end
    end    
  end

  describe "GET '/settings/account'" do    
    it "returns http success" do
      get :account
      response.should be_success
    end
  end

  describe "GET '/settings/payment'" do
    it "returns http success" do
      get :payment
      response.should be_success
    end
  end

  describe "GET '/settings/notification'" do
    it "returns http success" do
      get :notification
      response.should be_success
    end
  end


end
