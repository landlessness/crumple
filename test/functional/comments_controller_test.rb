require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @comment = comments(:one)
    @thought = thoughts(:deep)
    @person = people(:brian)
    sign_in @person
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, :comment => @comment.attributes, :thought_id => @thought
    end

    assert_redirected_to @thought
  end

  test "should show comment" do
    get :show, :id => @comment.to_param, :thought_id => @thought
    assert_response :success
  end

  test "should update comment" do
    put :update, :id => @comment.to_param, :comment => {:body => 'a revised comment'}, :thought_id => @thought
    assert_redirected_to @thought
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param, :thought_id => @thought
    end

    assert_redirected_to @thought
  end
end
