require 'test_helper'
require 'send_grid_email_test_helper'

class SendGridEmailsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @send_grid_email = send_grid_emails(:one)
    @person = people(:brian)
    sign_in @person
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:send_grid_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create thought from email using xml" do    
    send_grid_mail_fixture = send_grid_mail_fixture()
    
    assert send_grid_mail_fixture[:to] && send_grid_mail_fixture[:from]
    @request.user_agent = 'SendGrid 1.0'
    assert_difference('SendGridEmail.count') do
      post :create, send_grid_mail_fixture.merge(:format => 'xml')
    end
    thought = assigns(:send_grid_email).thought
    assert thought.body.include?("this is another test.\n"), 'thought should create  expected text'
    
    assert_equal 'in_drop_box', thought.state
    
    assert_response :ok
  end

  test "should create thought from html email " do    
    send_grid_html_mail_fixture = send_grid_html_mail_fixture()
    
    assert send_grid_html_mail_fixture[:to] && send_grid_html_mail_fixture[:from]
    @request.user_agent = 'SendGrid 1.0'
    assert_difference('SendGridEmail.count') do
      post :create, send_grid_html_mail_fixture.merge(:format => 'xml')
    end
    thought = assigns(:send_grid_email).thought
    assert thought.body.include?("\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982). \n\nhttp://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination\n"), 'thought should include expected text.'
    
    assert_equal 'in_drop_box', thought.state
    
    assert_response :ok
  end

  test "should create send_grid_email" do
    assert_difference('SendGridEmail.count') do
      post :create, :send_grid_email => @send_grid_email.attributes
    end

    assert_redirected_to send_grid_email_path(assigns(:send_grid_email))
  end

  test "should create send_grid_email using xml format" do
    assert_difference('SendGridEmail.count') do
      post :create, :send_grid_email => @send_grid_email.attributes, :format => :xml
    end

    assert_response :ok
  end

  test "should show send_grid_email" do
    get :show, :id => @send_grid_email.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @send_grid_email.to_param
    assert_response :success
  end

  test "should update send_grid_email" do
    put :update, :id => @send_grid_email.to_param, :send_grid_email => @send_grid_email.attributes
    assert_redirected_to send_grid_email_path(assigns(:send_grid_email))
  end

  test "should destroy send_grid_email" do
    assert_difference('SendGridEmail.count', -1) do
      delete :destroy, :id => @send_grid_email.to_param
    end

    assert_redirected_to send_grid_emails_path
  end
end
