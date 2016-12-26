require 'spec_helper'

describe SchoolController do

  describe "GET 'general'" do
    it "returns http success" do
      get 'general'
      response.should be_success
    end
  end

  describe "GET 'assignments'" do
    it "returns http success" do
      get 'assignments'
      response.should be_success
    end
  end

  describe "GET 'feedback'" do
    it "returns http success" do
      get 'feedback'
      response.should be_success
    end
  end

  describe "GET 'holidays'" do
    it "returns http success" do
      get 'holidays'
      response.should be_success
    end
  end

  describe "GET 'reachers'" do
    it "returns http success" do
      get 'reachers'
      response.should be_success
    end
  end

end
