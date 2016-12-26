require 'spec_helper'

describe Users::InvitationRegistrationsController do
  before { setup_abilities }
  before { @doctor = FactoryGirl.create(:doctor) }
  before { @doctor_patient = FactoryGirl.create(:doctor_patient, doctor: @doctor) }

  context "with signed in user" do
    before { @current_user = create_and_sign_in(:user) }

    describe "GET #new" do
      before { get :new, token: @doctor_patient.invitation_token }

      it "assigns correct user" do
        assigns(:user).should == @current_user
      end
      it "updates associated doctor_patient" do
        @doctor_patient.reload.user_id.should == @current_user.id
      end
      it{ should respond_with :success }
    end
  end

  context "without signed in user" do
    describe "GET #new" do
      before { get :new, token: @doctor_patient.invitation_token }

      it{ should respond_with :success }
    end
  end

end