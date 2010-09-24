require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @person = people(:brian)
    sign_in @person
  end

  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Subscription.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Subscription.any_instance.stubs(:valid?).returns(false)
    pricing_plan = pricing_plans(:gold)
    post :create, :pricing_plan_id => pricing_plan.to_param
    assert_template 'new'
  end
  
  def test_create_valid
    Subscription.any_instance.stubs(:valid?).returns(true)
    pricing_plan = pricing_plans(:gold)
    s = post :create, :pricing_plan_id => pricing_plan.to_param
    assert_redirected_to add_on_url(assigns(:pricing_plan).add_on)
  end
  
  def test_routes
    assert_recognizes({:controller => 'subscriptions', :action => 'create', :pricing_plan_id=>"1"}, {:path => '/pricing_plans/1/subscriptions', :method => :post})
    
    # TODO: get the generates test to pass. strange that it doesn't
    
    # assert_generates({:path => '/pricing_plans/1/subscriptions', :method => :post}, {:controller => 'subscriptions', :action => 'create'})
    
    # assert_routing({:path => "/pricing_plans/#{pricing_plans(:gold).to_param}/subscriptions", :method => :post}, {:controller => 'subscriptions', :action => 'create', :pricing_plan_id => pricing_plans(:gold).to_param})
  end
  
  def test_edit
    get :edit, :id => Subscription.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Subscription.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Subscription.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Subscription.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Subscription.first
    assert_redirected_to subscription_url(assigns(:subscription))
  end
  
  def test_destroy
    subscription = Subscription.first
    delete :destroy, :id => subscription
    assert_redirected_to subscription.pricing_plan.add_on
    assert !Subscription.exists?(subscription.id)
  end
end
