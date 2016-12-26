require 'spec_helper'

describe Prescription do
  it { should validate_presence_of(:symptom).with_message(/can't be blank/) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:medicine_id).with_message(/can't be blank/) }

  context "active" do
    before { subject.status = :active }
    it { should validate_presence_of(:administration_method).with_message(/can't be blank/) }
    it { should validate_presence_of(:expiration) }
    it { should validate_presence_of(:dosage) }
    it { should validate_presence_of(:doctor) }

    it { should_not validate_presence_of(:description) }
  end

  context "uploaded" do
    before { subject.status = :uploaded }

    it { should validate_presence_of(:doctor_name).with_message(/can't be blank/) }
    it { should validate_presence_of(:description).with_message(/can't be blank/) }
    it { should validate_presence_of(:expiration) }
    it { should validate_presence_of(:issue_date) }
    it { should_not validate_presence_of(:administration_method) }
    it { should_not validate_presence_of(:dosage) }
  end
end