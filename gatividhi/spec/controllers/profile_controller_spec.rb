require 'spec_helper'

describe ProfileController do

  describe "GET 'genenral'" do
    it "returns http success" do
      get 'genenral'
      response.should be_success
    end
  end

  describe "GET 'occupational'" do
    it "returns http success" do
      get 'occupational'
      response.should be_success
    end
  end

  describe "GET 'financial'" do
    it "returns http success" do
      get 'financial'
      response.should be_success
    end
  end

  describe "GET 'policies'" do
    it "returns http success" do
      get 'policies'
      response.should be_success
    end
  end

end
