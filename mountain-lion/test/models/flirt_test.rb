require 'test_helper'

describe Flirt do
  subject { Flirt }
  it "must have a mesage attribute" do
    subject.new.must_respond_to :message
  end
  describe "validations" do
    describe "#message" do
      it "must contain a message" do
        subject.new(message: nil).wont_be :valid?
      end
      it "must be longer than 5 characters" do
        subject.new(message: "1234").wont_be :valid?
        subject.new(message: "12345").must_be :valid?
      end
      it "must be unique disregarding the case" do
        FactoryGirl.create(:flirt, message: "test message")
        FactoryGirl.build(:flirt, message: "test message").wont_be :valid?
        FactoryGirl.build(:flirt, message: "TEST MESSAGE").wont_be :valid?
      end
    end
  end
end
