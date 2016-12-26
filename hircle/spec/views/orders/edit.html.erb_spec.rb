require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :card_expires_on => "MyString",
      :card_type => "MyString",
      :first_name => "MyString",
      :ip_address => "MyString",
      :last_name => "MyString",
      :card_number => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_path(@order), "post" do
      assert_select "input#order_card_expires_on[name=?]", "order[card_expires_on]"
      assert_select "input#order_card_type[name=?]", "order[card_type]"
      assert_select "input#order_first_name[name=?]", "order[first_name]"
      assert_select "input#order_ip_address[name=?]", "order[ip_address]"
      assert_select "input#order_last_name[name=?]", "order[last_name]"
      assert_select "input#order_card_number[name=?]", "order[card_number]"
    end
  end
end
