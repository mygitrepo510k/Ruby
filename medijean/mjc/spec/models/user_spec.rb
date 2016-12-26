require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user)}

  it "requires verification" do
    user.save!
    user.confirmed?.should be_false
  end
end