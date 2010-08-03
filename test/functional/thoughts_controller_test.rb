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

    assert_redirected_to [@person, assigns(:thought)]
  end

  test "should create thought from email" do    
    @send_grid_mail = send_grid_mail
    
    assert @send_grid_mail[:to] && @send_grid_mail[:from]
    assert_difference('Thought.count') do
      post :create_from_sendgrid, @send_grid_mail.merge(:format => 'xml'), :person_id => @person
    end
    thought = assigns(:thought)
    assert_equal 'this is another test.', thought.body
    
    assert_equal 'drop_box', thought.state
    
    assert_response :ok
  end

  test "should create thought from html email" do    
    @send_grid_html_mail = send_grid_html_mail
    
    assert @send_grid_html_mail[:to] && @send_grid_html_mail[:from]
    assert_difference('Thought.count') do
      post :create_from_sendgrid, @send_grid_html_mail.merge(:format => 'xml'), :person_id => @person
    end
    thought = assigns(:thought)
    assert_equal "\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982). \n\nhttp://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination", thought.body
    
    assert_equal 'drop_box', thought.state
    
    assert_response :ok
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
