require 'test_helper'

describe UserQuestion do
  subject { UserQuestion.new }
  it("must have a user attribute") { subject.must_respond_to(:user) }
  it("must have a profile_question attribute") { subject.must_respond_to(:profile_question) }
  it("must have a answer attribute") { subject.must_respond_to(:answer) }
  it("must have a get_answer method") { subject.must_respond_to(:get_answer) }
  describe "#get_answer" do
     let (:user) { FactoryGirl.build_stubbed(:user) }
    before do
      profile_question = FactoryGirl.build_stubbed(:profile_question, answer_type: "string" )
      @it = FactoryGirl.build_stubbed(:user_question, user: user, profile_question: profile_question )
    end
    it "returns string when profile_question.answer_type is \"string\"" do
      @it.get_answer.must_equal [ "MyString" ]
    end
    it "returns array when profile_question.answer_type is \"check_box\"" do
      profile_question = FactoryGirl.build_stubbed(:profile_question, answer_type: "check_box")
      uq = FactoryGirl.build_stubbed(:user_question, user: user, profile_question: profile_question)
      uq.get_answer.must_equal []
    end
    it "returns when profile_question.answer_type is \"select_list\"" do
      profile_question = FactoryGirl.build_stubbed(:profile_question, answer_type: "select_list")
      uq = FactoryGirl.build_stubbed(:user_question, user: user, profile_question: profile_question)
      uq.get_answer.must_equal []
    end
  end
end
