require 'test_helper'

class ThoughtsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @thought = thoughts(:deep)
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

  test "should create thought after signing in" do
    sign_out @person
    get :new
    assert !@controller.person_signed_in?, 'person should NOT be signed in'
    assert_response :success
    post :create, :thought => {:body => 'this is me typing a thought before i have signed in.', :tags_list => 'green blue red'}
    assert_redirected_to new_person_session_url
    # post :controller => 'devise/sessions', :action => 'new', :person => @person
    # assert_redirected_to new_thought_url
    assert_equal '/thoughts/auto_create?thought[body]=this+is+me+typing+a+thought+before+i+have+signed+in.&thought[tags_list]=green+blue+red', @controller.session[:"person_return_to"]
  end

  test "should create thought" do
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes
    end

    assert_redirected_to t=assigns(:thought)
    assert_equal 'web', t.origin
  end

  test "should create thought, tags and tag ownership" do
    
    tags = %w(blue brown black).sort
    
    assert !@person.tags.empty?, 'person should own any tags at the beginning'
    
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes.merge(:tags_list => tags.join(' '))
    end
    
    assert_equal ["bar", "black", "blue", "brown", "foo"], @person.tags.map(&:name).sort

    assert_redirected_to t=assigns(:thought)
  end

  test "should create thought from bookmarklet" do
    
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes.merge('origin' => 'bookmarklet')
    end

    assert_redirected_to t=assigns(:thought)
    assert_equal 'bookmarklet', t.origin
    
  end

  test "should create thought from bookmarklet_create" do
    assert_difference('Thought.count') do
      get :bookmarklet_create, :thought => @thought.attributes
    end

    assert_redirected_to bookmarklet_confirmation_thought_path(t=assigns(:thought))
    assert_equal 'bookmarklet', t.origin
    assert t.in_drop_box?
    
  end

  test "should create thought in drop box" do
    assert_difference('Thought.count') do
      post :create, :thought => {:body => 'this is a test thought', :state_event => 'put_in_drop_box'}
    end
    t = assigns(:thought)
    assert_redirected_to t
    assert t.in_drop_box?, 'thought expected to be in drop box.'
    assert_equal 'web', t.origin
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
  
  test "should update thought with new tag and tag ownership" do
    
    tags = %w(blue brown black).sort
    
    assert !@person.tags.empty?, 'person should own any tags at the beginning'
    
    put :update, :id => @thought.to_param, :thought => @thought.attributes.merge(:tags_list => tags.join(' '))
    
    assert_equal tags, @person.tags.map(&:name).sort

    assert_redirected_to t=assigns(:thought)
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
