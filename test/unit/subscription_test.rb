require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Subscription.new.valid?
  end
  def test_finding_subscription_from_person_and_pricing_plan
    pricing_plan = pricing_plans(:free)
    person = people(:brian)
    subscription = subscriptions(:brian_free)
    found_subscription = person.subscriptions.where(:pricing_plan_id => pricing_plan).first.to_param
    assert_equal subscription.to_param, found_subscription.to_param
  end
end
