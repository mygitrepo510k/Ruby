require 'spec_helper'

describe DoctorClaim do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:doctor) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:user) }
  it { should belong_to(:doctor) }

  it "defaults to pending status" do
    doctor_claim = DoctorClaim.new
    expect(doctor_claim.status).to eq(:pending)
  end
end
