require 'spec_helper'

describe AdminController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'store'" do
    it "returns http success" do
      get 'store'
      response.should be_success
    end
  end

end
