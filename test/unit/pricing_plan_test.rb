require 'test_helper'

class PricingPlanTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PricingPlan.new.valid?
  end
  
  
end
