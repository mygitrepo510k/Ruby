require 'spec_helper'

describe Notification do
  context "parameters" do
    it "checks for missing parameters" do
      FactoryGirl.build(:notification, notification_type: :incoming_prescription).should have(1).error_on(:parameters)
    end

    it "supports notifications with zero parameters" do
      FactoryGirl.build(:notification, notification_type: :welcome).should have(0).errors_on(:parameters)
    end

    it "supports notifications with one parameter" do
      FactoryGirl.build(:notification, notification_type: :incoming_prescription, parameters: { sender_name: "x" }).should have(0).errors_on(:parameters)
    end
  end

  it { should validate_presence_of :user }
  # @todo modify the spec for read attribute, it should be boolean
  # No need to validate a field(:read) that is boolean, as long as we can set that field as boolean database level.
  # it { should validate_presence_of :read }
  it { should validate_presence_of :notification_type }
end
