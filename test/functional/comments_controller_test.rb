require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @comment = comments(:one)
    @thought = thoughts(:one)
    @person = people(:brian)
    sign_in @person
  end

  test "should get index" do
    get :index, :person_id => @person, :thought_id => @thought
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new, :person_id => @person, :thought_id => @thought
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, :comment => @comment.attributes, :person_id => @person, :thought_id => @thought
    end

    assert_redirected_to [@person, @thought]
  end

  test "should show comment" do
    get :show, :id => @comment.to_param, :person_id => @person, :thought_id => @thought
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @comment.to_param, :person_id => @person, :thought_id => @thought
    assert_response :success
  end

  test "should update comment" do
    put :update, :id => @comment.to_param, :comment => @comment.attributes, :person_id => @person, :thought_id => @thought
    assert_redirected_to [@person, @thought]
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param, :person_id => @person, :thought_id => @thought
    end

    assert_redirected_to [@person, @thought]
  end
end
