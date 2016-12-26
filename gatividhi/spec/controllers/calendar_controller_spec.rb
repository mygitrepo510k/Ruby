require 'spec_helper'

describe CalendarController do

  describe "GET 'month'" do
    it "returns http success" do
      get 'month'
      response.should be_success
    end
  end

  describe "GET 'week'" do
    it "returns http success" do
      get 'week'
      response.should be_success
    end
  end

  describe "GET 'day'" do
    it "returns http success" do
      get 'day'
      response.should be_success
    end
  end

end
