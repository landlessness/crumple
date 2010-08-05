require 'test_helper'

class ThoughtsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @thought = thoughts(:one)
    @person = people(:brian)
    sign_in @person
  end

  test "should get index" do
    get :index, :person_id => @person
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end

  test "should get new" do
    get :new, :person_id => @person
    assert_response :success
  end

  test "should create thought" do
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes, :person_id => @person
    end

    assert_redirected_to [@person, t=assigns(:thought)]
    assert_equal 'website', t.origin
    
  end

  test "should create thought from bookmarklet" do
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes.merge(:origin => 'bookmarklet'), :person_id => @person
    end

    assert_redirected_to [@person, t=assigns(:thought)]
    assert_equal 'bookmarklet', t.origin
    
  end

  test "should create thought in drop box" do
    assert_difference('Thought.count') do
      post :create, :thought => {:body => 'this is a test thought', :state_event => 'put_in_drop_box'}, :person_id => @person
    end
    t = assigns(:thought)
    assert_redirected_to [@person, t]
    assert t.in_drop_box?, 'thought expected to be in drop box.'
    assert_equal 'website', t.origin
  end

  test "should show thought" do
    get :show, :id => @thought.to_param, :person_id => @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @thought.to_param, :person_id => @person
    assert_response :success
  end

  test "should update thought" do
    put :update, :id => @thought.to_param, :thought => @thought.attributes, :person_id => @person
    assert_redirected_to [@person, assigns(:thought)]
  end

  test "should archive thought" do
    put :archive, :id => @thought.to_param, :person_id => @person
    assert_redirected_to [@person, assigns(:thought)]
  end

  test "should destroy thought" do
    assert_difference('Thought.count', -1) do
      delete :destroy, :id => @thought.to_param, :person_id => @person
    end

    assert_redirected_to person_thoughts_url(@person)
  end
end
