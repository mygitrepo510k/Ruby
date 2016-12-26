require 'test_helper'

describe Admin::DashboardController do
  let(:subject) { Admin::DashboardController.new }
  it("must have an index method") { subject.must_respond_to :index }
end
