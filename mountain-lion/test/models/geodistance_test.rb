require 'test_helper'

describe Geodistance do
  before do
    @from = { latitude: 45.724409, longitude: 16.069066 }
    @to = { latitude: 45.686651, longitude: 16.141641 }
  end
  subject { Geodistance.new(@from, @to) }
  it("has a from") { subject.must_respond_to(:from) }
  it("has a to") { subject.must_respond_to(:to) }
  it("has a distance") { subject.must_respond_to(:distance) }
  describe "radian conversions" do
    before do
    end
    it "transforms from latitude into radians" do
      subject.from[:latitude].must_be_close_to(0.798041486)
    end
    it "transforms from longitude into radians" do
      subject.from[:longitude].must_be_close_to(0.280458109)
    end
    it "transforms to latitude into radians" do
      subject.to[:latitude].must_be_close_to(0.797382484)
    end
    it "transforms to longitude into radians" do
      subject.to[:longitude].must_be_close_to(0.281724782)
    end
  end
  describe "#distance" do
    it "calculates a good distance" do
      subject.distance.must_be_close_to(7.02, 0.5)
    end
  end
end
