require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @project = projects(:exercise)
    @person = people(:brian)
    sign_in @person
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    Project.any_instance.stubs(:valid?).returns(true)
    assert_difference('Project.count') do
      post :create, :project => {:name => 'Foobar'}
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "invalid create project" do
    Project.any_instance.stubs(:valid?).returns(false)
    post :create, :project => {:name => 'Foobar'}
    assert_template 'new'
  end

  test "should show project" do
    get :show, :id => @project.to_param
    assert_response :success
  end

  test "should show project with archived thoughts" do
    get :show, :id => @project.to_param, :archived_thoughts => true
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @project.to_param
    assert_response :success
  end

  test "should update project" do
    Project.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @project.to_param, :project =>  {:name => 'Fuzzbaz'}
    assert_redirected_to project_path(assigns(:project))
  end
  
  test "invalid update project" do
    Project.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @project.to_param, :project =>  {:name => 'Fuzzbaz'}
    assert_template 'edit'
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, :id => @project.to_param
    end

    assert_redirected_to projects_path
  end
end
