require 'spec_helper'

describe Doctor do
  context "if active" do
    before { subject.status = :active }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :physician_id }
    it { should validate_presence_of :clinic }
  end

  context "if not active" do
    before { subject.status = :inactive }
    it { should_not validate_presence_of :first_name }
    it { should_not validate_presence_of :last_name }
    it { should_not validate_presence_of :last_name }
    it { should_not validate_presence_of :physician_id }
  end
end