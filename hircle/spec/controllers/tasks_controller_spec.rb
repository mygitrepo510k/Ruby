require 'spec_helper'

describe TasksController do
  describe "GET #index" do  
    
    it "reponds successfully" do
      get :index
      expect(response).to be_success
    end
=begin
    it "respnds with all tasks" do
      user = User.first
      get "/users/sign_in"
      assert_select "new_user" do
        assert_select "user_email", "admin@example.com"
        assert_select "user_password", "12345678"
        assert_select "input[type=submit]", "submit"
      end
      task1, task2 = Task.create!, Task.create!
      get :index
      expect(assigns(:tasks)).to match_array([task1,task2])
    end
=end
  end

end
