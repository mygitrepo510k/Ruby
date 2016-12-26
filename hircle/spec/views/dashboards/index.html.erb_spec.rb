require 'spec_helper'

describe "dashboards/index" do
  before(:each) do
    assign(:dashboards, [
      stub_model(Dashboard),
      stub_model(Dashboard)
    ])
  end

  it "renders a list of dashboards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
