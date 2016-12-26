require 'test_helper'

class DepartmentsControllerTest < ActionController::TestCase
  setup do
    @department = departments(:design)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create department" do
    assert_difference('Department.count') do
      post :create, department: { company_id: @department.company_id, description: @department.description, name: @department.name }
    end

    assert_redirected_to department_path(assigns(:department))
  end

  test "should show department" do
    get :show, id: @department
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @department
    assert_response :success
  end

  test "should update department" do
    
    put :update, id: @department, department: { company_id: @department.company_id, description: @department.description, name: @department.name }
    assert_redirected_to department_path(assigns(:department))
  end

  test "should destroy department" do
    assert_difference('Department.count', -1) do
      delete :destroy, id: @department
    end

    assert_redirected_to departments_path
  end
  

  test "should get employees" do
    get :employees,id: @department,:format => :json
    assert_response :success
    assert_not_nil assigns(:employess)
    #puts assigns(:statistical)
  end  
   test "should post addemployees" do
    post :addemployees,:ids => users(:user3)['id'],:department_id => @department['id'],:format => :json
    #assert_response :success
    assert_not_nil  @response.body
    assert_equal 'ok', @response.body
    
  end
  
  test "should get documents" do
    get :documents,id: @department,:format => :json
    assert_response :success
    assert_not_nil assigns(:resources)
    puts assigns(:resources).to_json
  end
  test "should get activities" do
    get :activities,id: @department,:format => :json
    assert_response :success
    assert_not_nil assigns(:array)    
  end
end
