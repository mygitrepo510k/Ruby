require 'spec_helper'

describe DoctorPatient do
  it "validates the presence of user or email" do
    doctor_patient = FactoryGirl.build(:doctor_patient, user: nil, email: nil)

    doctor_patient.valid?.should be_false
    doctor_patient.errors[:base].should include("user or email needs to be specified to tag a user")
  end

  context "when tagged" do
    before { subject.status = :active }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:doctor) }
  end

  context "when invited" do
    before { subject.status = :invited }
    it { should validate_presence_of(:prescription) }
  end

  context "when active" do
    before { subject.status = :active }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:doctor) }
    it { should validate_presence_of(:user) }
  end

end
