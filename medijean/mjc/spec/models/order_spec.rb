require 'spec_helper'

describe Order do
  it { should validate_presence_of(:total) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:placed_at) }
  it { should validate_presence_of(:sub_total) }
  it { should validate_presence_of(:tax) }
  it { should validate_presence_of(:taxname) }
  it { should validate_presence_of(:shipping_address) }
  
  context "creation" do
    it "creates immutable shipping address" do
      order = FactoryGirl.create(:order)
      address = FactoryGirl.create(:address)

      order.shipping_address = address
      order.save

      address_attributes = address.attributes.except("id", "updated_at", "created_at")

      address_attributes["immutable"] = false
      Address.where(address_attributes).first.id.should == address.id

      address_attributes["immutable"] = true
      Address.where(address_attributes).first.id.should == order.shipping_address.id
    end
  end
end
