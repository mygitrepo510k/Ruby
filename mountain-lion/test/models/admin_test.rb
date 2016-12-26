require 'test_helper'

describe Admin do
  subject { FactoryGirl.build(:admin)}
  it "must be valid" do
    subject.must_be :valid?
  end
end
