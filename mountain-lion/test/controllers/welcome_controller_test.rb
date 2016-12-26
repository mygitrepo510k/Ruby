require 'test_helper'

describe WelcomeController do
  let (:subject) {WelcomeController.new}
  describe "#home" do
    before { get :home }
    describe "not logged in" do
      it "should assign a new user variable" do
        assigns(:user).wont_be_nil
      end
    end
  end
end
