require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create task" do
    task = Task.new(:one)
  end
end
