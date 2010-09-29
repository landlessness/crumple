require 'test_helper'

class ThoughtsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @thought = thoughts(:deep)
    @person = people(:brian)
    sign_in @person
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:thoughts)
    # make sure all forms use :as => :thought
    assert_no_tag :tag => 'form', :attributes => {:action => '/plain_text_thoughts/'+@thought.to_param}
  end

  test "should get index with query" do
    get :index, :q => 'test'
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end

  test "should get index with blank query" do
    get :index, :q => ''
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end
  
  test "should get index with project & tag" do
    get :index, :project_id => projects(:crumple).to_param, :tag_id => tags(:foo).to_param
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end
  
  test "should get index with project" do
    get :index, :project_id => projects(:crumple).to_param
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end
  
  test "should get index with tag" do
    get :index, :tag_id => tags(:foo).to_param
    assert_response :success
    assert_not_nil assigns(:thoughts)
  end
  
  def test_should_get_new
    get :new
    assert_response :success
    assert_not_nil assigns(:thought), 'plain text thought should be set'
  end

  test "should get new signed out" do
    sign_out @person
    assert !@controller.person_signed_in?, 'person should NOT be signed in'
    get :new
    assert_response :success
  end

  test "should redirect to auto_create signing in" do
    sign_out @person
    get :new
    assert !@controller.person_signed_in?, 'person should NOT be signed in'
    assert_response :success
    post :create, :thought => {:body => 'this is me typing a thought before i have signed in.', :tags_list => 'green blue red'}
    assert_redirected_to new_person_session_url
    assert_equal '/thoughts/auto_create?thought[body]=this+is+me+typing+a+thought+before+i+have+signed+in.&thought[tags_list]=green+blue+red', @controller.session[:"person_return_to"]
  end

  test "should auto create thought" do
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    assert_difference('Thought.count') do
      post :auto_create, :thought => @thought.attributes
    end

    assert_redirected_to thought_path(t=assigns(:thought))
    assert_equal 'web', t.origin
  end

  test "invalid auto create thought" do
    PlainTextThought.any_instance.stubs(:valid?).returns(false)
    post :auto_create, :thought => @thought.attributes
    assert_template 'new'
  end

  def test_add_on
    music_add_on = add_ons(:music_notation)
    abc_notation = %(X:1
    T:Grace notes
    M:6/8
    K:C
    {g}A3 A{g}AA|{gAGAG}A3 {g}A{d}A{e}A|])
    assert_difference('Thought.count') do
      post :create, :thought => {:add_on => music_add_on.to_param, :music_notation_thought => {:body => abc_notation}}
    end
    assert_redirected_to thought_path(t=assigns(:thought))
    assert t.is_a?(MusicNotationThought), 'should be a music notation thought'
    assert_equal @person, t.person
    assert_equal 'web', t.origin
    get :show, :id => t.to_param
    assert_response :success
  end

  def test_should_create_thought
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes
    end

    assert_redirected_to thought_path(t=assigns(:thought))
    assert_equal @person, t.person
    assert_equal 'web', t.origin
  end

  test "invalid create thought" do
    PlainTextThought.any_instance.stubs(:valid?).returns(false)
    post :create, :thought => @thought.attributes
    assert_template 'new'  
  end

  def test_create_thought_tags_tag_ownership
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    tags = %w(blue brown black).sort
    
    assert !@person.tags.empty?, 'person should own some tags at the beginning'
    
    assert_difference('Thought.count') do
      post :create, :thought => @thought.attributes.merge(:tags_list => tags.join(' '))
    end
    
    assert_equal ["bar", "black", "blue", "brown", "foo"], @person.tags.map(&:name).sort

    assert_redirected_to thought_path(t=assigns(:thought))
    
    assert_equal tags, t.taggings.map{|t|t.tag.name}.sort
    
  end

  def test_should_create_thought_from_bookmarklet_create
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    assert_difference('Thought.count') do
      get :bookmarklet_create, :thought => @thought.attributes
    end

    assert_redirected_to bookmarklet_confirmation_thought_path(t=assigns(:thought))
    assert_equal 'bookmarklet', t.origin
    assert t.in_drop_box?
    
  end
  
  test "invalid create thought from bookmarklet_create" do
    PlainTextThought.any_instance.stubs(:valid?).returns(false)
    
    get :bookmarklet_create, :thought => @thought.attributes
    assert_response :unprocessable_entity
  end

  test "should do bookmarklet confirm" do
    get :bookmarklet_confirmation, :id => @thought.to_param
    assert_response :success
  end

  test "should create thought in drop box" do
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    assert_difference('Thought.count') do
      post :create, :thought => {:body => 'this is a test thought', :state_event => 'put_in_drop_box', :type => 'PlainTextThought'}
    end
    assert_redirected_to thought_path(t=assigns(:thought))
    assert t.in_drop_box?, 'thought expected to be in drop box.'
    assert_equal 'web', t.origin
  end

  def test_should_show_thought
    get :show, :id => @thought.to_param
    assert_response :success
    # make sure all forms use :as => :thought and the proper URL
    assert_no_tag :tag => 'select', :attributes => {:name => 'plain_text_thought[project_id]'}
    assert_no_tag :tag => 'form', :attributes => {:action => '/plain_text_thoughts/'+@thought.to_param}
  end

  test "should focus thought" do
    get :focus, :id => @thought.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @thought.to_param
    assert_response :success
  end

  def test_should_update_thought
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    put :update, :id => @thought.to_param, :thought => @thought.attributes
    assert_redirected_to thought_path(assigns(:thought))
  end
  
  test "invalid update thought" do
    PlainTextThought.any_instance.stubs(:valid?).returns(false)
    
    put :update, :id => @thought.to_param, :thought => @thought.attributes
    assert_template 'edit'
  end
  
  def test_should_update_thought_with_new_tag_and_tag_ownership
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    tags = %w(blue brown black).sort
    
    assert !@person.tags.empty?, 'person should own any tags at the beginning'
    
    put :update, :id => @thought.to_param, :thought => @thought.attributes.merge(:tags_list => tags.join(' '))
    
    assert_equal tags, @person.tags.map(&:name).sort

    assert_redirected_to thought_path(assigns(:thought))
  end

  test "should archive thought" do
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    put :archive, :id => @thought.to_param
    assert_redirected_to t=assigns(:thought)
    assert t.archived?
  end

  test "should accept thought" do
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    @thought.put_in_drop_box!
    put :accept, :id => @thought.to_param
    assert_redirected_to t=assigns(:thought)
    assert t.active?
  end

  test "should activate thought" do
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    @thought.archive!
    put :activate, :id => @thought.to_param
    assert_redirected_to t=assigns(:thought)
    assert t.active?
  end

  test "should put thought in drop box" do
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    put :put_in_drop_box, :id => @thought.to_param
    assert_redirected_to t=assigns(:thought)
    assert t.in_drop_box?
  end

  test "invalid put thought in drop box" do
    PlainTextThought.any_instance.stubs(:valid?).returns(false)
    
    put :put_in_drop_box, :id => @thought.to_param
    assert_template 'edit'
  end

  def test_should_update_project
    PlainTextThought.any_instance.stubs(:valid?).returns(true)
    
    assert_equal projects(:crumple), @thought.project
    put :update_project, :id => @thought.to_param, :thought => {:project_id => projects(:exercise).to_param}
    assert_equal projects(:exercise), @thought.reload.project
  end

  test "should destroy thought" do
    assert_difference('Thought.count', -1) do
      delete :destroy, :id => @thought.to_param
    end

    assert_redirected_to thoughts_url
  end

  test 'routes with inheritance' do
    assert_routing '/thoughts', :controller => 'thoughts', :action => 'index'
    assert_routing "/thoughts/#{thoughts(:deep).to_param}", :controller => 'thoughts', :action => 'show', :id => thoughts(:deep).to_param
  end
  
end
