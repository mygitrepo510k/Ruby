require 'test_helper'

describe ProfileAnswer do
  let(:profile_question) { FactoryGirl.build_stubbed(:profile_question) }
  subject { FactoryGirl.build_stubbed(:profile_answer, profile_question: profile_question) }
  it("has a profile_question attribute") { subject.must_respond_to(:profile_question) }
  it("has a answer attribute") { subject.must_respond_to(:answer) }
  describe "#to_s" do
    it "returns answer when calling to_s" do
      subject.to_s.must_equal subject.answer
    end
  end
end
