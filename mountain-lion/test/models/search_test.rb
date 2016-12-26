require 'test_helper'

describe Search do
  subject { Search.new('M', nil) }
  it("has a gender method") { subject.must_respond_to(:gender) }
  it("has a users method") { subject.must_respond_to(:users) }
  it("has a params method") { subject.must_respond_to(:params) }
  describe "#gender" do
    it "returns F if initialized with M" do
      Search.new('M', nil).gender.must_equal('F')
    end
    it "returns M if initialized with F" do
      Search.new('F', nil).gender.must_equal('M')
    end
    it "returns M if initialized with anything else" do
      Search.new('X', nil).gender.must_equal('M')
    end
  end
end
