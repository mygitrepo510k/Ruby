require 'test_helper'

describe "Flirts Integration Test" do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:flirt) { FactoryGirl.create(:flirt, message: "Voulez-vous coucher avec moi ce soir?") }
  setup do
    flirt
    admin.activate!
    login_integration_user(admin)
  end
  teardown do
    logout_integration_user(admin)
  end
  describe "all flirts" do
    before do
      visit admin_flirts_path
    end
    it "must have a good response" do
      response_status.must_equal 200
    end
    it "must have All flirts in the header" do
      page.must_have_content("Flirts")
    end
    it "must show a created flirt on the page" do
      page.must_have_content(flirt.message)
    end
  end
  describe "one flirt" do
    before do
      visit admin_flirt_path(flirt)
    end
    it "must have a 200 response" do
      response_status.must_equal 200
    end
    it "must have a flirt message in the page" do
      page.must_have_content(flirt.message)
    end
    it "it must be a good path" do
      current_path.must_equal admin_flirt_path(flirt)
    end
  end
  describe "Creating flirt" do
    before do
      visit new_admin_flirt_path
    end
    it "must have a 200 response" do
      response_status.must_equal 200
    end
    it "must create a new flirt" do
      fill_in('Message', with: "How you doin?")
      click_button("Create Flirt")
      current_path.must_equal admin_flirts_path
      page.must_have_content("How you doin?")
    end
  end
  describe "Editing flirt" do
    before do
      @flirt = FactoryGirl.create(:flirt, message: "Ole Ole!")
      visit edit_admin_flirt_path(@flirt)
    end
    it "must have a 200 response" do
      response_status.must_equal 200
    end
    it "must edit a flirt" do
      fill_in('Message', with: "Ola ola!")
      click_button("Update Flirt")
      current_path.must_equal admin_flirt_path(@flirt)
      page.must_have_content("Ola ola!")
    end
  end
  it "deletes the flirt" do
    flirt = FactoryGirl.create(:flirt, message: "one two three")
    visit admin_flirts_path
    page.must_have_content("one two three")
    assert_difference('Flirt.count', -1) do
      page.find("a[href='#{admin_flirt_path(flirt)}'][data-method=delete]").click
    end
    current_path.must_equal admin_flirts_path
    page.wont_have_content("one two three")
  end
end
