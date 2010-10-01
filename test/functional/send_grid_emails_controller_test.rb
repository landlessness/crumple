require 'test_helper'
require 'send_grid_email_test_helper'

class SendGridEmailsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @send_grid_email = send_grid_emails(:one)
    @send_grid_user_agent = 'SendGrid 1.0'
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
  
  def test_should_create_thought_from_email_using_xml
    sign_out @person
    assert !@controller.person_signed_in?
    SendGridEmail.any_instance.stubs(:valid?).returns(true)
    
    send_grid_mail_fixture = send_grid_mail_fixture()
    
    assert send_grid_mail_fixture[:to] && send_grid_mail_fixture[:from]
    @request.user_agent = @send_grid_user_agent
    assert_difference('SendGridEmail.count') do
      post :create, :send_grid_email => send_grid_mail_fixture, :format => 'xml'
    end
    thought = assigns(:send_grid_email).thought
    assert thought.body.include?("this is another test.\n"), 'thought should create  expected text'
    
    assert_equal 'in_drop_box', thought.state
    assert_equal 'email', thought.origin
    
    assert_response :ok
  end

  def test_invalid_create_thought_from_email_using_xml
    sign_out @person
    assert !@controller.person_signed_in?
    
    SendGridEmail.any_instance.stubs(:valid?).returns(false)
    
    send_grid_mail_fixture = send_grid_mail_fixture()
    
    assert send_grid_mail_fixture[:to] && send_grid_mail_fixture[:from]
    @request.user_agent = 'SendGrid 1.0'
    post :create, :send_grid_email => send_grid_mail_fixture, :format => 'xml'
    assert_response :internal_server_error
  end

  def test_should_create_thought_from_html_email
    sign_out @person
    assert !@controller.person_signed_in?
    
    SendGridEmail.any_instance.stubs(:valid?).returns(true)
    
    send_grid_html_mail_fixture = send_grid_html_mail_fixture()
    
    assert send_grid_html_mail_fixture[:to] && send_grid_html_mail_fixture[:from]
    @request.user_agent = 'SendGrid 1.0'
    assert_difference('SendGridEmail.count') do
      post :create, :send_grid_email => send_grid_html_mail_fixture, :format => 'xml'
    end
    thought = assigns(:send_grid_email).thought
    assert thought.body.include?("\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982). \n\nhttp://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination\n"), 'thought should include expected text.'
    
    assert_equal 'in_drop_box', thought.state
    assert_equal 'email', thought.origin
    
    assert_response :ok
  end

  test "should create send_grid_email" do
    sign_out @person
    assert !@controller.person_signed_in?
    
    SendGridEmail.any_instance.stubs(:valid?).returns(true)
    assert_not_nil @send_grid_email
    assert_difference('SendGridEmail.count') do
      post :create, :send_grid_email => @send_grid_email.attributes
    end

    assert_redirected_to send_grid_email_path(assigns(:send_grid_email))
  end

  test "invalid create send_grid_email" do
    sign_out @person
    assert !@controller.person_signed_in?
    
    SendGridEmail.any_instance.stubs(:valid?).returns(false)
    post :create, :send_grid_email => @send_grid_email.attributes
    assert_template 'new'
  end

  test "should create send_grid_email using xml format" do
    sign_out @person
    assert !@controller.person_signed_in?
    
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
    SendGridEmail.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @send_grid_email.to_param, :send_grid_email => @send_grid_email.attributes
    assert_redirected_to send_grid_email_path(assigns(:send_grid_email))
  end

  test "invalid update send_grid_email" do
    SendGridEmail.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @send_grid_email.to_param, :send_grid_email => @send_grid_email.attributes
    assert_template 'edit'
  end

  test "should destroy send_grid_email" do
    assert_difference('SendGridEmail.count', -1) do
      delete :destroy, :id => @send_grid_email.to_param
    end

    assert_redirected_to send_grid_emails_path
  end

  # this test throws an error because of
  # the following bug in assert_recognizes: https://rails.lighthouseapp.com/projects/8994/tickets/5005-error-on-assert_recognizes-when-used-on-a-route-with-constraint
  # to test: curl --data '' --header 'content-type: text/xml' -X POST --user-agent 'SendGrid 1.0' 'localhost:3000/thoughts.xml?to=brian%2B4444@crumpleapp.com&text=hello%0Atags%3Acurl%0Aproject%3Atest&subject=hi'
  def test_route
    # @request.user_agent = @send_grid_user_agent
    # @request.env['HTTP_USER_AGENT'] = @send_grid_user_agent
    # request = ActionController::TestRequest.new
    # assert_equal @send_grid_user_agent, request.user_agent
    # ActionController::TestRequest.any_instance.stubs(:env).returns({'HTTP_USER_AGENT' => @send_grid_user_agent})
    # assert_equal @send_grid_user_agent, request.env['HTTP_USER_AGENT']

    ActionController::TestRequest.any_instance.stubs(:user_agent).returns(@send_grid_user_agent)
    # assert_recognizes({:controller => 'send_grid_emails', :action => 'create', :format => 'xml'}, {:method => :post, :path => '/thoughts.xml'})
  end
  def test_email_posts
    sign_out @person
    assert !@controller.person_signed_in?
    
    post :create, :format => :xml, :send_grid_email => {:to => 'brian+4444@crumpleapp.com', :text => "hello\ntags: curl\nproject: test", :subject => 'hi'}
  end
end
