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
    Comment.any_instance.stubs(:valid?).returns(true)
    assert_difference('Comment.count') do
      post :create, :comment => {:body => 'this is a comment'}, :thought_id => @thought, :format => :js
    end
    assert_response :success
  end
  
  test 'create invalid' do
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create, :thought_id => @thought, :format => :js
    assert_response :unprocessable_entity
  end

  test "should show comment" do
    get :show, :id => @comment.to_param, :thought_id => @thought
    assert_response :success
  end

  test "should update comment" do
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @comment.to_param, :comment => {:body => 'a revised comment'}, :thought_id => @thought, :format => :js
    assert_response :success
  end

  test "invalid update comment" do
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @comment.to_param, :comment => {:body => 'a revised comment'}, :thought_id => @thought, :format => :js
    assert_response :unprocessable_entity
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param, :thought_id => @thought, :format => :js
    end

    assert_response :success
  end
end
