require 'spec_helper'

describe Task do
  it "Creating Task" do
    Task.create(
      :assignor_id => 1,
      :company_id => 1,
      :description => "This is testing task",
      :due_date => Date.new,
      :priority=> "1",
      :resource_id => 1,
      :start_date => (Date.new - 1.day),
      :status => "pending",
      :title => "Test Task"
      )
      
    task  = Task.all.first
    expect(task.assignor_id).to eq(1)
  end
end
