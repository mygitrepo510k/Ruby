require 'spec_helper'

describe HomeController do

  context "when logged out" do
    before { get :index }
    it { should render_template :index }
  end

  context "when logged in" do
    before do
      sign_in FactoryGirl.create(:patient_user)
      get :index
    end

    it { should redirect_to users_dashboard_path }
  end
end
