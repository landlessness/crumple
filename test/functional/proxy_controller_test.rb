require 'test_helper'

class ProxyControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @person = people(:brian)
    @add_on = add_ons(:music_notation)
    @body = 'H: a very historic tune'
    @thought = AddOnThought.subclazz_create! :person => @person, :add_on => @add_on, :music_notation_thought => {:body => @body}
    sign_in @person
  end
  
  def test_routes
    assert_recognizes({:controller => 'proxy', :action => 'new', :add_on_id=>'1'}, {:path => '/add_ons/1/proxy/new', :method => :get})
    assert_recognizes({:controller => 'proxy', :action => 'show', :add_on_id=>'1', :id => '2' }, {:path => '/add_ons/1/proxy/2', :method => :get})
  end
  
  def test_get_new
    get :new, :add_on_id => @add_on.to_param
    assert_response :success
    assert_match /http:\/\/localhost:3001\/music_notation_thoughts\/new\?platform=crumple/, assigns(:external_url)
    assert_tag :tag => 'textarea', :attributes => {:name => 'music_notation_thought[body]'}
  end

  def test_get_show
    get :show, :add_on_id => @add_on.to_param, :id => @thought.to_param
    assert_response :success
    assert_match /http:\/\/localhost:3001\/music_notation_thoughts\/\d{1,30}\?platform=crumple/, assigns(:external_url)
    assert_tag :tag => 'p', :content => @body
  end
end