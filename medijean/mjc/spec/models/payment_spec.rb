require 'spec_helper'

describe Payment do
  it { should validate_presence_of :operation }
  it { should validate_presence_of :message }
  it { should validate_presence_of :order }
  it { should validate_presence_of :charge_id }
end
