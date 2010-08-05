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

    assert_redirected_to t=assigns(:thought)
    assert_equal 'website', t.origin
    
  end

  test "should create thought from bookmarklet" do
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes.merge(:origin => 'bookmarklet')
    end

    assert_redirected_to t=assigns(:thought)
    assert_equal 'bookmarklet', t.origin
    
  end

  test "should create thought in drop box" do
    assert_difference('Thought.count') do
      post :create, :thought => {:body => 'this is a test thought', :state_event => 'put_in_drop_box'}
    end
    t = assigns(:thought)
    assert_redirected_to t
    assert t.in_drop_box?, 'thought expected to be in drop box.'
    assert_equal 'website', t.origin
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
    assert_redirected_to assigns(:thought)
  end

  test "should archive thought" do
    put :archive, :id => @thought.to_param
    assert_redirected_to assigns(:thought)
  end

  test "should destroy thought" do
    assert_difference('Thought.count', -1) do
      delete :destroy, :id => @thought.to_param
    end

    assert_redirected_to thoughts_url
  end
end
