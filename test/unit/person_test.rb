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
    assert !@person.subscribed_to_pricing_plan?(pricing_plan), 'should NOT be subscribed to a pricing plan.'
    @person.subscriptions.create :pricing_plan => pricing_plan
    assert @person.subscribed_to_pricing_plan?(pricing_plan), 'should be subscribed to pricing plan.'
  end
  def test_person_equality
    add_on = add_ons(:music_notation)
    assert @person == add_on.developer
  end
end
