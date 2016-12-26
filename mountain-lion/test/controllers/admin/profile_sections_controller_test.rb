require 'test_helper'

describe Admin::ProfileSectionsController do
  subject { Admin::ProfileSectionsController.new }
  let(:profile_section) { FactoryGirl.create(:profile_section) }
  setup do
    admin = FactoryGirl.build_stubbed(:admin)
    admin.activate!
    login_user(admin)
  end
  describe "#index" do
    it("must have a index method") { subject.must_respond_to(:index) }
    before { get :index }
    it "must assign a profile_sections variable" do
      assigns(:profile_sections).wont_be_nil
    end
    it "must have page method on profile_sections" do
      assigns(:profile_sections).must_respond_to(:page)
    end
  end
  it("must have a new method") { subject.must_respond_to(:new)}
  describe "#new" do
    it "must assign a profile_section variable of type ProfileSection" do
      get :new
      assigns(:profile_section).must_be_instance_of(ProfileSection)
    end
  end
  describe "#create" do
    it("must have a create method") { subject.must_respond_to(:create)}
    before do
      params = { profile_section: { name: "Profile", displayed: true} }
      post :create, params, {}
    end
    it "should create a new profile section" do
      assigns(:profile_section).must_be :valid?
    end
    it "should assign a profile_section variable" do
      assigns(:profile_section).wont_be_nil
    end
    it "must assign profile_section with name \"Profile\"" do
      assigns(:profile_section).name.must_equal("Profile")
    end
    it "must assign profile_section displayed? with true" do
      assigns(:profile_section).displayed.must_equal(true)
    end
    it "should redirect to admin_profile_sections_path" do
      response.redirect?.must_equal true
      response.location.must_equal admin_profile_sections_url
    end
  end
  describe "#edit" do
    it("must have an edit method") { subject.must_respond_to(:edit)}
    it "must assign the correct variable" do
      get :edit, {id: profile_section.id }
      assigns(:profile_section).must_equal profile_section
    end
    it "raises url generation error without an id param" do
      -> {get :edit}.must_raise(ActionController::UrlGenerationError)
    end
    it "raises a record not found error when a wrong id is entered" do
      -> {get :edit, {id: 2000303201}}.must_raise(ActiveRecord::RecordNotFound)
    end
  end
  describe "#update" do
    it("must have an update method") { subject.must_respond_to(:update)}
    before do
      params = { id: profile_section.id, profile_section: { name: "Other Name", displayed: false}}
      put :update, params
    end
    it "should assign a profile_section variable" do
      assigns(:profile_section).wont_be_nil
    end
    it "should update the parameters" do
      section = assigns(:profile_section)
      section.name.must_equal("Other Name")
      section.displayed.must_equal false
    end
    it "should redirect to the profile section show page upon success" do
      response.redirect?.must_equal true
      response.location.must_equal admin_profile_section_url(profile_section)
    end
  end
  describe "#destroy" do
    it("must have a destroy method") { subject.must_respond_to(:destroy)}
    before do
      delete :destroy, {id: profile_section.id}
    end
    it "should assign a right variable" do
      assigns(:profile_section).must_equal profile_section
    end
    it "should destroy the profile section" do
      -> {ProfileSection.find(profile_section.id)}.must_raise(ActiveRecord::RecordNotFound)
    end
    it "should redirect to the admin profile sections path" do
      response.redirect?.must_equal true
      response.location.must_equal admin_profile_sections_url
    end
  end
end
