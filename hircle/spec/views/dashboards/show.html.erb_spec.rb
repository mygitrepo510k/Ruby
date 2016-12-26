require 'spec_helper'

describe "dashboards/show" do
  before(:each) do
    @dashboard = assign(:dashboard, stub_model(Dashboard))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
