require 'spec_helper'

describe Admin::UsersController do
  context "user lock feature" do
    let(:admin_user) { FactoryGirl.create(:admin_user) }
    let(:user) { FactoryGirl.create(:user) }

    before { sign_in admin_user }

    it "supports locking users" do
      put :lock, :id => user.id
      response.response_code.should == 302
      user.reload
      user.access_locked?.should == true
    end

    it "supports unlocking users" do
      user.lock_access!
      put :unlock, :id => user.id
      response.response_code.should == 302
      user.reload
      user.access_locked?.should be_blank

    end
  end

end