require 'spec_helper'

describe Profile do
  it { should validate_presence_of(:first_name).with_message(/can't be blank/) }
  it { should validate_presence_of(:last_name).with_message(/can't be blank/) }
  it { should validate_presence_of(:health_card_number).with_message(/can't be blank/) }
  it { should validate_presence_of(:phone) }
  it { should belong_to(:user) }
end
