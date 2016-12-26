require 'test_helper'

describe ProfileVisit do
  subject { ProfileVisit.new }
  it("has a user") { subject.must_respond_to(:user) }
  it("has a visitor") { subject.must_respond_to(:visitor)}
  it("has a recent scope") {ProfileVisit.must_respond_to(:recent)}
end
