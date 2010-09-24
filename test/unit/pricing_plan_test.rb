require 'test_helper'

class PricingPlanTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PricingPlan.new.valid?
  end
  
  def test_get_fee
    p = pricing_plans(:free)
    assert_equal 0, p.monthly_fee_cents
    assert_equal 0.0, p.monthly_fee
    p = pricing_plans(:silver)
    assert_equal 999, p.monthly_fee_cents
    assert_equal 9.99, p.monthly_fee
    p = pricing_plans(:gold)
    assert_equal 1999, p.monthly_fee_cents
    assert_equal 19.99, p.monthly_fee
    p = pricing_plans(:nil_fee)
    assert_nil p.monthly_fee_cents
    assert_equal 0.0, p.monthly_fee    
    p = pricing_plans(:negative_fee)
    assert_equal -1999, p.monthly_fee_cents
    assert_equal 0.0, p.monthly_fee    
  end
  
  def test_set_fee
    p = pricing_plans(:free)
    p.monthly_fee = 12.34
    assert_equal 1234, p.monthly_fee_cents
    assert_equal 12.34, p.monthly_fee
    p.monthly_fee = 0.0
    assert_equal 0, p.monthly_fee_cents
    assert_equal 0.0, p.monthly_fee
    p.update_attributes :monthly_fee => nil
    assert_equal 0, p.monthly_fee_cents
    assert_equal 0.0, p.monthly_fee
    p.monthly_fee = nil
    assert_equal 0, p.monthly_fee_cents
    assert_equal 0.0, p.monthly_fee
    p.monthly_fee = -12.34
    assert_equal 0, p.monthly_fee_cents
    assert_equal 0.0, p.monthly_fee
  end
  
end
