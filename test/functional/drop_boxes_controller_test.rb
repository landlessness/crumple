require 'test_helper'

class DropBoxesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @drop_box = drop_boxes(:brians_drop_box)
    @person = people(:brian)
    sign_in @person
  end

  test "should get index" do
    get :index, :person_id => @person
    assert_response :success
    assert_not_nil assigns(:drop_boxes)
  end

  test "should get new" do
    get :new, :person_id => @person
    assert_response :success
  end

  test "should create drop_box" do
    assert_difference('DropBox.count') do
      post :create, :drop_box => {:name => 'foo', :secret => 'bar'}, :person_id => @person
    end

    assert_redirected_to [@person, assigns(:drop_box)]
  end

  test "should show drop_box" do
    get :show, :id => @drop_box.to_param, :person_id => @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @drop_box.to_param, :person_id => @person
    assert_response :success
  end

  test "should update drop_box" do
    put :update, :id => @drop_box.to_param, :drop_box => {:name => 'fuzz', :secret => 'baz'}, :person_id => @person
    assert_redirected_to  [@person, assigns(:drop_box)]
  end

  test "should destroy drop_box" do
    assert_difference('DropBox.count', -1) do
      delete :destroy, :id => @drop_box.to_param, :person_id => @person
    end

    assert_redirected_to person_drop_boxes_path(@person)
  end
end
