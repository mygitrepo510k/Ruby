require 'spec_helper'

describe Devise::SessionsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  context "sign in" do
    let(:user) { FactoryGirl.build(:user) }
    let(:password) { user.password }

    before { user.save!; user.confirm! }

    context "with valid credentials" do
      before { post :create, :user => {:email => user.email, :password => password} }

      it { should redirect_to users_dashboard_path  }
    end

    context "with bad credentials" do
      before do
        post :create, :user => {:email => user.email, :password => "bad"}
      end

      it { should render_template "devise/sessions/new" }
    end
  end
end