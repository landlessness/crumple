require 'test_helper'

class DropBoxesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @drop_box = drop_boxes(:brians_drop_box)
    @person = people(:brian)
    sign_in @person
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drop_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drop_box" do
    assert_difference('DropBox.count') do
      post :create, :drop_box => {:name => 'foo', :secret => 'bar'}
    end

    assert_redirected_to my_drop_box_url
  end

  test "should show drop_box" do
    get :show, :id => @drop_box.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @drop_box.to_param
    assert_response :success
  end

  test "should update drop_box" do
    put :update, :id => @drop_box.to_param, :drop_box => {:name => 'fuzz', :secret => 'baz'}
    assert_redirected_to my_drop_box_url
  end

  test "should destroy drop_box" do
    assert_difference('DropBox.count', -1) do
      delete :destroy, :id => @drop_box.to_param
    end

    assert_redirected_to @person
  end
end
