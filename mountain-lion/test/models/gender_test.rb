require 'test_helper'

describe Gender do
  describe "#all" do
    it "responds to #all" do
      Gender.must_respond_to :all
    end
    it "returns a collection of genders" do
      Gender.all.must_be_instance_of Array
    end
  end
end
