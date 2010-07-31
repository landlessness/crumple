require 'test_helper'

class ThoughtsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @thought = thoughts(:one)
    @person = people(:brian)
    sign_in @person
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thought" do
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes
    end

    assert_redirected_to thought_path(assigns(:thought))
  end

  test "should create thought from email" do    
    @send_grid_mail = send_grid_mail
    
    assert @send_grid_mail[:to] && @send_grid_mail[:from]
    assert_difference('Thought.count') do
      @request.accept = 'send_grid'
      post :create_from_sendgrid, @send_grid_mail
    end
    thought = assigns(:thought)
    assert_equal 'this is another test.', thought.body
    
    assert_equal 'drop_box', thought.state
    
    assert_response :ok
  end

  test "should show thought" do
    get :show, :id => @thought.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @thought.to_param
    assert_response :success
  end

  test "should update thought" do
    put :update, :id => @thought.to_param, :thought => @thought.attributes
    assert_redirected_to thought_path(assigns(:thought))
  end

  test "should destroy thought" do
    assert_difference('Thought.count', -1) do
      delete :destroy, :id => @thought.to_param
    end

    assert_redirected_to thoughts_path
  end
end
