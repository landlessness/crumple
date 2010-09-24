require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = people(:brian)
  end

  def test_person_creates_drop_box
    p = Person.create! :email => 'brian@foobar.net', :password => 'password'
    assert_match /^brian\d{10}$/, p.drop_box.name
  end
  def test_subscribed_to_pricing_plan
    pricing_plan = pricing_plans(:gold)
    
    assert !@person.pricing_plans.exists?(pricing_plan), 'should NOT be subscribed to a pricing plan.'
    assert !@person.subscribes_to?(pricing_plan), 'should NOT be subscribed to a pricing plan.'
    
    pricing_plan.subscriptions.create :person => @person
    
    assert @person.pricing_plans.exists?(pricing_plan), 'should be subscribed to pricing plan.'
    assert @person.subscribes_to?(pricing_plan), 'should be subscribed to pricing plan.'
  end
  def test_subscribed_to_pricing_plan
    add_on = add_ons(:textile)
    pricing_plan = pricing_plans(:free_textile)
    
    assert !@person.subscribes_to?(add_on), 'should NOT be subscribed to a pricing plan.'
    
    pricing_plan.subscriptions.create :person => @person
    
    assert @person.subscribes_to?(add_on), 'should be subscribed to pricing plan.'
  end
  def test_person_equality
    add_on = add_ons(:music_notation)
    assert @person == add_on.developer
  end
  def test_double_through_to_pricing_plans
    assert !@person.subscriptions.empty?
    assert !@person.pricing_plans.empty?
  end
end
