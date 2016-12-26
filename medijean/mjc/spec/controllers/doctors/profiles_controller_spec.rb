require 'spec_helper'

describe Doctors::ProfilesController do
  before do
    create_and_sign_in(:doctor_user)
  end


  describe "GET #show" do
    before { @doctor_patient = FactoryGirl.create(:doctor_patient) }
    before { get :show, id: 1 }

    it "returns success" do
      should respond_with :success
    end
  end

end