require 'spec_helper'

describe Address do
  it { should validate_presence_of :country }
  it { should validate_presence_of :city }
  it { should validate_presence_of :street }

  context "that is marked immutable" do
    it "allows creation" do
      Address.create!(:city => "Mississauga", :province => "ON", :street => "10 Happiness boulevard", :immutable => true)
    end

    it "does not allow updates" do
      address = Address.create!(:city => "Mississauga", :province => "ON", :street => "10 Happiness boulevard", :immutable => true)
      address.province = "AB"
      expect { address.save }.to  raise_error(ActiveRecord::ReadOnlyRecord)
    end

  end

  it "validates canadian postal codes" do
    address = FactoryGirl.create(:address)
    address.postal_code = "12345"
    address.should have(1).error_on(:postal_code)
  end

end
