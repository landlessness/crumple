require 'test_helper'

class ScreenshotsControllerTest < ActionController::TestCase
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
    get :show, :id => Screenshot.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Screenshot.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Screenshot.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to screenshot_url(assigns(:screenshot))
  end
  
  def test_edit
    get :edit, :id => Screenshot.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Screenshot.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Screenshot.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Screenshot.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Screenshot.first
    assert_redirected_to screenshot_url(assigns(:screenshot))
  end
  
  def test_destroy
    screenshot = Screenshot.first
    delete :destroy, :id => screenshot
    assert_redirected_to screenshots_url
    assert !Screenshot.exists?(screenshot.id)
  end
end
