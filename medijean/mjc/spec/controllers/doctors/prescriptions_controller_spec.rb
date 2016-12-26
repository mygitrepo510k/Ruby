require 'spec_helper'

describe Doctors::PrescriptionsController do
  before do
    setup_abilities
    @user           = FactoryGirl.create(:doctor_user)
    @doctor_patient = FactoryGirl.create(:doctor_patient, doctor_id: @user.linked_doctor.id, doctor: nil)
    sign_in(@user)
  end

  describe "GET #new" do
    before { @ability.can [:read, :create], Prescription }
    before { get :new, doctor_patient_id: @doctor_patient.id  }

    specify do
      should respond_with :success
    end
  end

  describe "POST #create" do
    before { @ability.can [:read, :create], Prescription }
    before { @prescription_attributes = FactoryGirl.attributes_for(:prescription).merge(medicine_id: 1) }
    before { post :create, doctor_patient_id: @doctor_patient.id, prescription: @prescription_attributes }

    it "successfully builts prescription and saves it" do
      response.should redirect_to doctors_dashboard_path
    end
  end

  describe "GET #show" do
    before { @ability.can [:read], Prescription }
    before { @prescription = FactoryGirl.create(:prescription, doctor_patient_id: @doctor_patient.id )}
    before { get :show, doctor_patient_id: @doctor_patient.id, id: @prescription.id }

    it "responds with success" do
      should respond_with :success
    end
  end
end