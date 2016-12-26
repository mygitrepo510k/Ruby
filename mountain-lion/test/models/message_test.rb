require 'test_helper'

describe Message do
  describe "fields" do
    subject { Message.new }
    it("has a sender") { subject.must_respond_to :sender }
    it("has a recipient") { subject.must_respond_to :recipient }
    it("has a subject") { subject.must_respond_to :subject }
    it("has a body") { subject.must_respond_to :body }
    it("has a read? attribute") { subject.must_respond_to :read? }
    it("has a set_read method") { subject.must_respond_to :set_read }
  end
  describe "scopes" do
    it("has a unread scope") { Message.must_respond_to :unread }
  end
  describe "validations" do
    subject { FactoryGirl.build_stubbed(:message) }
    it "has a valid factory" do
      subject.must_be :valid?
    end
    describe "#subject" do
      it "is present" do
        subject.subject = nil
        subject.wont_be :valid?
      end
      it "is between 2 and 50 characters" do
        subject.subject = 'a' * 4
        subject.wont_be :valid?
        subject.subject = 'a' * 5
        subject.must_be :valid?
        subject.subject = 'a' * 50
        subject.must_be :valid?
        subject.subject = 'a' * 51
        subject.wont_be :valid?
      end
    end
    describe "#body" do
      it "is present" do
        subject.body = nil
        subject.wont_be :valid?
      end
      it "is not longer than 5000 characters" do
        subject.body = 'a' * 5001
        subject.wont_be :valid?
      end
    end
  end
  describe "#set_read" do
    subject { FactoryGirl.create(:message) }
    it "will wet the message read attribute and save it when called" do
      subject.read?.must_equal false
      subject.set_read
      Message.find(subject.id).must_be :read?
    end
  end
end
