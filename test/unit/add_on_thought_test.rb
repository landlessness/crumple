require 'test_helper'

class AddOnThoughtTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AddOnThought.new.valid?
  end
  
  def test_subclazz
    subclazz = AddOnThought.subclazz_for('music_notation_thought')
    assert_equal ActiveResource::Formats::JsonFormat, subclazz.format
    thought = subclazz.find 1
    assert_match /Speed the Plough/, thought.body
  end
  
  def test_find_by_add_on_and_id
    add_on_element_name = 'music_notation_thought'
    add_on = AddOn.find_by_element_name(add_on_element_name)
    assert add_on.is_a?(AddOn)
    subclazz = Class.new(AddOnThought){self.site = add_on.site; self.element_name = add_on.element_name}
    assert_equal ActiveResource::Formats::JsonFormat, subclazz.format
    thought = subclazz.find(1)
    assert_match /Speed the Plough/, thought.body
  end
end
