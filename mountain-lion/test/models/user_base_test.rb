require 'test_helper'

describe UserBase do
  describe "required parameters" do
    subject { User.new }
    it("must respond to #username") { subject.must_respond_to :username }
    it("must respond to #email") { subject.must_respond_to :email }
    it("must respond to #date_of_birth") { subject.must_respond_to :date_of_birth }
    it("must respond to #gender") { subject.must_respond_to :gender }
    it("must respond to #country") { subject.must_respond_to :country }
    it("must respond to #city") { subject.must_respond_to :city }
    it("must respond to #zip_code") { subject.must_respond_to :zip_code }
    it("must respond to #password") { subject.must_respond_to :password }
    it("must respond to #password_confirmation") { subject.must_respond_to :password_confirmation }
    it("must respond to #latitude") { subject.must_respond_to :latitude }
    it("must respond to #longitude") { subject.must_respond_to :longitude }
    it("must respond to #user_profile") { subject.must_respond_to :user_profile }
    it("must respond to #type") { subject.must_respond_to :type }
  end
  describe "validations" do
    subject {FactoryGirl.build(:user_base)}
    it "factory user must be valid" do
      subject.must_be :valid?, subject.errors
    end
    describe "#username" do
      it "must be present" do
        subject.username = nil
        subject.wont_be :valid?
      end
      it "must have a username between 5 and 15 characters" do
        subject.must_be :valid?
        subject.username = "1234"
        subject.wont_be :valid?
        subject.username = "1234567890123456"
        subject.wont_be :valid?
      end
      describe "unique username" do
        before(:each) do
          FactoryGirl.create(:user, username: "testusername")
        end
        it "must have a unique username" do
          user = FactoryGirl.build_stubbed(:user, username: "testusername")
          user.wont_be :valid?
        end
        it "must have a unique username" do
          user = FactoryGirl.build_stubbed(:user, username: "testusername".upcase)
          user.wont_be :valid?
        end
      end
      it "must include letters and numbers only" do
        subject.username = "x_21_432$%&"
        subject.wont_be :valid?
      end
    end
    describe "#email" do
      it "must be present" do
        subject.email = nil
        subject.wont_be :valid?
      end
      it "must be a real email" do
        subject.email = "sddjds.sdadhe"
        subject.wont_be :valid?
      end
      it "must be unique" do
        FactoryGirl.create(:user, email: subject.email)
        subject.wont_be :valid?
      end
      it "must be unique regardles of case" do
        FactoryGirl.create(:user, email: subject.email.upcase)
        subject.wont_be :valid?
      end
    end
  end
end
