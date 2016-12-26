require 'test_helper'
describe SessionsController do
  let(:subject) { SessionsController.new }
  describe "#new" do
    before { get :new }
    it "should assign a new user variable" do
      assigns(:user).wont_be_nil
    end
  end
  describe "login and logout" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      user.activate!
    end
    describe "#create" do
      describe "succesful login with username" do
        before do
          post :create, username_or_email: user.username.upcase, password: "secret", remember: true
        end
        it "should assign the right user" do
          assigns(:user).must_equal(user)
        end
        it "should return the right flash message" do
          flash[:notice].must_equal(I18n.t('controllers.sessions.create.success'))
        end
        it "sets the current_user variable" do
          assigns(:current_user).wont_be_nil
        end
      end
      describe "succesful login with email" do
        before do
          post :create, username_or_email: user.email.upcase, password: "secret", remember: true
        end
        it "should assign the right user" do
          assigns(:user).must_equal(user)
        end
        it "should return the right flash message" do
          flash[:notice].must_equal(I18n.t('controllers.sessions.create.success'))
        end
        it "sets the current_user variable" do
          assigns(:current_user).wont_be_nil
        end
        it "should redirect to user_path" do
          response.redirect?.must_equal true
          response.location.must_equal users_url
        end
      end
      describe "unsuccesful login" do
        before do
          post :create, username_or_email: user.username, password: "wrong", remember: true
        end
        it "should not assign current_user" do
          assigns(:current_user).wont_equal true
        end
      end
    end
    describe "#destroy" do
      before do
        login_user(user)
        get :destroy
      end
      it "should logout the current_user" do
        session[:user_id].must_be_nil
      end
      it "should have the right flash message" do
        flash[:notice].must_equal(I18n.t('controllers.sessions.destroy.success'))
      end
      it "should remove the current_user" do
        assigns(:current_user).wont_equal true
      end
    end
  end
end

