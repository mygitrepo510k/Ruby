require 'spec_helper'

describe Assignment do

  before("Creates Assignment of task") do
    @task = Task.create(
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
    @user = User.create(
      :email=>'admin@hircle.com',
      :password=>"12345678",
      :password_confirmation=>"12345678",
      :role_id=>1,
      :first_name =>"admin"
    )
  end

  it "Creates Assignment of task" do
    Assignment.create(
      :assignee_id => @user.id,
      :task_id => @task.id
    )
    
    assignment = Assignment.all.first
    expect(assignment.task.class).to eq(Task)
  end
end
