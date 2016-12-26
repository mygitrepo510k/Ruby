require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
        :card_expires_on => "Card Expires On",
        :card_type => "Card Type",
        :first_name => "First Name",
        :ip_address => "Ip Address",
        :last_name => "Last Name",
        :card_number => "Card Number"
      ),
      stub_model(Order,
        :card_expires_on => "Card Expires On",
        :card_type => "Card Type",
        :first_name => "First Name",
        :ip_address => "Ip Address",
        :last_name => "Last Name",
        :card_number => "Card Number"
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Card Expires On".to_s, :count => 2
    assert_select "tr>td", :text => "Card Type".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Ip Address".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Card Number".to_s, :count => 2
  end
end
