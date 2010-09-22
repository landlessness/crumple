require 'test_helper'

class AddOnThoughtsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @person = people(:brian)
    sign_in @person
  end

  def test_routes
    AddOn.all.map{|add_on| add_on.underscored_name}.each do |add_on_underscored_name|
      assert_routing({:path => "/#{add_on_underscored_name}_thoughts", :method => :get},{:controller => "add_on_thoughts", :action => 'index', :add_on => add_on_underscored_name})
      assert_routing({:path => "/#{add_on_underscored_name}_thoughts", :method => :post},{:controller => "add_on_thoughts", :action => 'create', :add_on => add_on_underscored_name})
      assert_routing({:path => "/#{add_on_underscored_name}_thoughts/1", :method => :get},{:controller => "add_on_thoughts", :action => 'show', :add_on => add_on_underscored_name, :id => '1'})
    end
  end
end

