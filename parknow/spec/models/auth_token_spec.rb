require 'spec_helper'

describe AuthToken do
  it { should validate_presence_of :device_id }
  it { should validate_presence_of :device_type }
  it { should validate_presence_of :app_type }
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }
  it { should belong_to(:user) }
end