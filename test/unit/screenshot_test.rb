require 'test_helper'

class ScreenshotTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Screenshot.new.valid?
  end
end
