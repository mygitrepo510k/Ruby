require 'test_helper'

describe ProfileQuestion do
  subject { ProfileQuestion.new }
  let(:profile_section) { FactoryGirl.build_stubbed(:profile_section)}
  it("must have a question attribute") { subject.must_respond_to(:question)}
  it("must have a answer_type attribute") { subject.must_respond_to(:answer_type)}
  describe "#answer_type" do
    it "must be within the required range" do
      symbols = ProfileQuestion::ANSWER_TYPES
      symbols.each do |sym|
        question = FactoryGirl.build_stubbed(:profile_question, profile_section: profile_section, answer_type: sym)
        question.must_be :valid?
      end
    end
    it "wont be outside the valid range" do
      question = FactoryGirl.build_stubbed(:profile_question, profile_section: profile_section, answer_type: "something_else")
      question.wont_be :valid?
    end
  end
end
