require 'test_helper'

class TaggingsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @tag = tags(:foo)
    @tagging = taggings(:one)
    @person = people(:brian)
    sign_in @person
  end

  test "should create tagging" do
    assert_not_nil @tagging.thought
    assert_difference('Tagging.count') do
      post :create, :thought=>{:tags_list_concat=>'newtag'}, :thought_id=>@tagging.thought.to_param, :format => :js
    end
    assert_response :success
  end

  test "should destroy tagging" do
    assert_not_nil @person
    assert_not_nil @tag
    assert_not_nil @tagging.person
    assert_not_nil @tagging.tag
    
    assert_equal 'foo', @tagging.tag.name
    assert_difference('Tagging.count', -1) do
      delete :destroy, :id => @tagging.to_param, :format => :js
    end

    assert_response :success
  end

end
