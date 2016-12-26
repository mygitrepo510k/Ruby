require 'test_helper'

describe UserActivity do
  subject { UserActivity.new(gender: 'M') }
  it("must have a user attribute") { subject.must_respond_to(:user)}
  it("must have a activity_type attribute") { subject.must_respond_to(:activity_type)}
  it("must have a gender attribute") { subject.must_respond_to(:gender)}
  describe "#activity_type" do
    it "must be one of the UserActivity::ACTIVITY_TYPES" do
      UserActivity::ACTIVITY_TYPES.each do |act|
        subject.activity_type = act
        subject.must_be :valid?
      end
    end
    it "wont be anything else" do
      subject.activity_type = "something else"
      subject.wont_be :valid?
    end
  end
end
