require 'test_helper'

describe UserPhoto do
  subject {UserPhoto.new}
  it("has a image attribute") { subject.must_respond_to :image }
  it("has a description attribute") { subject.must_respond_to :description }
  it("has a user attribute") { subject.must_respond_to :user }
  it("has a approved attribute") {subject.must_respond_to :approved }
  describe "validations" do
    let(:user) {FactoryGirl.build_stubbed(:user)}
    subject { FactoryGirl.build_stubbed(:user_photo, user_id: user.id)}
    it "factory is valid" do
      subject.must_be :valid?
    end
    it "has an image" do
      subject.image = nil
      subject.wont_be :valid?
    end
    it "has a user" do
      subject.user_id = nil
      subject.wont_be :valid?
    end
    it "shouldn't be approved after creation" do
      subject.wont_be :approved?
    end
  end
end
