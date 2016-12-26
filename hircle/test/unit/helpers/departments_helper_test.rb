require 'test_helper'

class DepartmentsHelperTest < ActionView::TestCase
  
  test "shoul new inner class" do
       e=ProtocolJsonHelper::Employee.new
       e.email="uuuuuuuuuuuuuuuu"
       assert !e.nil?
     
  end
end
