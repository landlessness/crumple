require 'test_helper'

class AddOnTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AddOn.new.valid?
  end
end
