require 'test_helper'

class PricingPlansControllerTest < ActionController::TestCase
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
    get :show, :id => PricingPlan.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PricingPlan.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PricingPlan.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to pricing_plan_url(assigns(:pricing_plan))
  end
  
  def test_edit
    get :edit, :id => PricingPlan.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    PricingPlan.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PricingPlan.first
    assert_template 'edit'
  end
  
  def test_update_valid
    PricingPlan.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PricingPlan.first
    assert_redirected_to pricing_plan_url(assigns(:pricing_plan))
  end
  
  def test_destroy
    pricing_plan = PricingPlan.first
    delete :destroy, :id => pricing_plan
    assert_redirected_to pricing_plans_url
    assert !PricingPlan.exists?(pricing_plan.id)
  end
end
