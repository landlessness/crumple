require 'test_helper'

class AddOnsControllerTest < ActionController::TestCase
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
    get :show, :id => AddOn.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    AddOn.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    AddOn.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to add_on_url(assigns(:add_on))
  end
  
  def test_edit
    get :edit, :id => AddOn.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    AddOn.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AddOn.first
    assert_template 'edit'
  end
  
  def test_update_valid
    AddOn.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AddOn.first
    assert_redirected_to add_on_url(assigns(:add_on))
  end
  
  def test_destroy
    add_on = AddOn.first
    delete :destroy, :id => add_on
    assert_redirected_to add_ons_url
    assert !AddOn.exists?(add_on.id)
  end
  
end
