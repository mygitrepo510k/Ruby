require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :card_expires_on => "Card Expires On",
      :card_type => "Card Type",
      :first_name => "First Name",
      :ip_address => "Ip Address",
      :last_name => "Last Name",
      :card_number => "Card Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Card Expires On/)
    rendered.should match(/Card Type/)
    rendered.should match(/First Name/)
    rendered.should match(/Ip Address/)
    rendered.should match(/Last Name/)
    rendered.should match(/Card Number/)
  end
end
