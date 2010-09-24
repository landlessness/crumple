require 'test_helper'

class AddOnTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AddOn.new.valid?
  end
  def test_mixed_case_name
    a = add_ons(:music_notation)
    assert_equal 'Music Notation', a.name
    assert_equal 'http://labs.crumpleapp.com', a.site
    assert_equal 'music_notation_thought', a.element_name
    a = add_ons(:textile)
    assert_equal 'Textile', a.name
    assert_equal 'http://labs.crumpleapp.com', a.site
    assert_equal 'textile_thought', a.element_name
  end
  def test_belongs_to_person
    p = people(:brian)
    a = p.developed_add_ons.create :name => 'Drawing'
    assert_equal p, a.developer
    assert_equal p.developed_add_ons.first.to_param, a.to_param
  end
end
