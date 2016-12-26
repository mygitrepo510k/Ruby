require 'test_helper'

describe ProfileSection do
  let(:subject) { FactoryGirl.build(:profile_section) }
  it("has a name attribute") { subject.must_respond_to :name }
  it("has a displayed attribute") { subject.must_respond_to :displayed }
  it("has a slug attribute") {subject.must_respond_to :slug}
  describe "#name" do
    it "must be present" do
      subject.name = nil
      subject.wont_be :valid?
    end
    it "must be composed only of characters" do
      subject.name.must_match(/[a-z]/i)
    end
    it "must be unique" do
      subject.save
      FactoryGirl.build_stubbed(:profile_section, name: subject.name).
        wont_be :valid?
    end
  end
  describe "#slug" do
    it "must replace the whitespace with dashes and make the name lowercase" do
      subject.name = "My Description"
      subject.slug.must_equal "my-description"
    end
  end
  describe "#to_s" do
    it "returns profile_section name when calling to_s" do
      subject.to_s.must_equal subject.name
    end
  end
end
