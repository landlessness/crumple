require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @thought = thoughts(:deep)
    @person = people(:brian)
    sign_in @person
  end
  
  test "show a page signed in" do
    assert @controller.person_signed_in?, 'person should be signed in'
    get :show, :id => 'about'
    assert_response :success
  end
  test "show a page signed out" do
    sign_out @person
    assert !@controller.person_signed_in?, 'person should NOT be signed in'
    get :show, :id => 'about'
    assert_response :success
  end
end
