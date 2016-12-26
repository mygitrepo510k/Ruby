require 'spec_helper'

describe LineItem do
  it { should validate_presence_of(:unit)}
  it { should validate_presence_of(:quantity)}
  it { should validate_presence_of(:price)}
  it { should validate_presence_of(:medicine)}

  it "validates price" do
    line_item = FactoryGirl.create(:line_item)
    line_item.price.should == line_item.medicine.price * line_item.quantity and line_item.should be_valid
    line_item.price = 1234
    line_item.should have(1).error_on(:price)
  end

  it "validates units" do
    line_item = FactoryGirl.create(:line_item)
    line_item.unit.should == line_item.medicine.unit and line_item.should be_valid
    if line_item.unit == :grams
      line_item.unit = :units 
    else
      line_item.unit = :grams 
    end
    
    line_item.should have(1).error_on(:unit)
  end
end 