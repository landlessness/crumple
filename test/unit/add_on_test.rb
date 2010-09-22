require 'test_helper'

class AddOnTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AddOn.new.valid?
  end
  def test_mixed_case_name
    a = add_ons(:music_notation)
    assert_equal 'Music Notation', a.name
    assert_equal 'music_notation', a.underscored_name
    a = add_ons(:textile)
    assert_equal 'Textile', a.name
    assert_equal 'textile', a.underscored_name
  end
end
