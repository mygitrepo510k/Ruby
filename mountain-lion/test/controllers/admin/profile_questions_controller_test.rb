require 'test_helper'

describe Admin::ProfileQuestionsController do
  subject { Admin::ProfileQuestionsController.new }
  let(:profile_section) { FactoryGirl.create(:profile_section) }
  let(:profile_question) { FactoryGirl.create(:profile_question, profile_section: profile_section) }
  setup do
    admin = FactoryGirl.build_stubbed(:admin)
    admin.activate!
    login_user(admin)

  end
  describe "#index" do
    it("must have a index method") { subject.must_respond_to(:index) }
    before { get :index }
    it "must assign a profile_questions variable" do
      assigns(:profile_questions).wont_be_nil
    end
    it "must have page method on profile_questions" do
      assigns(:profile_questions).must_respond_to(:page)
    end
  end
  it("must have a new method") { subject.must_respond_to(:new)}
  describe "#new" do
    it "must assign a profile_question variable of type ProfileQuestion" do
      get :new
      assigns(:profile_question).must_be_instance_of(ProfileQuestion)
    end
  end
  describe "#create" do
    it("must have a create method") { subject.must_respond_to(:create)}
    before do
      params = { profile_question: { question: "What is your favorite color", answer_type: :string, profile_section_id: profile_section.id} }
      post :create, params, {}
    end
    it "should create a new profile question" do
      assigns(:profile_question).must_be :valid?
    end
    it "should assign a profile_question variable" do
      assigns(:profile_question).wont_be_nil
    end
    it "must assign profile_question with question \"What is your favorite color\"" do
      assigns(:profile_question).question.must_equal("What is your favorite color")
    end
    it "should assign a profile_question with a profile_section" do
      assigns(:profile_question).profile_section.must_equal profile_section
    end
    it "should redirect to admin_profile_questions_path" do
      response.redirect?.must_equal true
      response.location.must_equal admin_profile_questions_url
    end
  end
  describe "#edit" do
    it("must have an edit method") { subject.must_respond_to(:edit)}
    it "must assign the correct variable" do
      get :edit, {id: profile_question.id }
      assigns(:profile_question).must_equal profile_question
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
      params = { id: profile_question.id, profile_question: { question: "Another question"}}
      put :update, params
    end
    it "should assign a profile_question variable" do
      assigns(:profile_question).wont_be_nil
    end
    it "should update the parameters" do
      question = assigns(:profile_question)
      question.question.must_equal("Another question")
    end
    it "should redirect to the profile question show page upon success" do
      response.redirect?.must_equal true
      response.location.must_equal admin_profile_question_url(profile_question)
    end
  end
  describe "#destroy" do
    it("must have a destroy method") { subject.must_respond_to(:destroy)}
    before do
      delete :destroy, {id: profile_question.id}
    end
    it "should assign a right variable" do
      assigns(:profile_question).must_equal profile_question
    end
    it "should destroy the profile question" do
      -> {ProfileQuestion.find(profile_question.id)}.must_raise(ActiveRecord::RecordNotFound)
    end
    it "should redirect to the admin profile questions path" do
      response.redirect?.must_equal true
      response.location.must_equal admin_profile_questions_url
    end
  end
end

