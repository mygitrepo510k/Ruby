require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  setup do
    @department = departments(:design)
  end
  
  test "should department all" do 
    assert Department.all.size > 0
  end
   
end
