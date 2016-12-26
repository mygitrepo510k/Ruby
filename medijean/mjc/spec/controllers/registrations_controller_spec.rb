require 'spec_helper'

describe Users::RegistrationsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  context "#profile" do
    pending "renders profile completion form"
  end

  context "#complete_profile" do
    let(:user)               { FactoryGirl.create(:user, profile: nil) }
    let(:profile_attributes) { FactoryGirl.attributes_for(:profile, :phone =>  {p1: "123", p2: "123", p3: "1234"}) }

    before { sign_in user }

    context "with valid input" do
      it "creates user profile" do

        post :complete_profile,
          profile: profile_attributes

        profile = assigns(:profile)
        profile.should be_present
        profile.user.should == user
      end
    end

    context "with invalid input" do
      pending "returns form back to user if health card number is missing"
    end
  end

  context "sign up" do
    let (:user) { FactoryGirl.build(:user) }
    before { post :create, :user => {:email => user.email, :password => user.password, :password_confirmation => user.password } }
    it { should redirect_to(root_path) }
  end
end
