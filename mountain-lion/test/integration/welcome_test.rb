require 'test_helper'

describe "Welcome Integration Test" do
  describe "frontpage" do
    before { visit welcome_path }
    it "should have a signup form on the frontpage" do
      page.find('#signup-form').wont_be_nil
    end
  end
end
