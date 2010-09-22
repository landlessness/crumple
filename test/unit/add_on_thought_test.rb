require 'test_helper'

class AddOnThoughtTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AddOnThought.new.valid?
  end
  def test_calling_active_resource
    
  end
  def test_find_by_add_on_and_id
    add_on_element_name = 'music_notation_thought'
    add_on = AddOn.find_by_element_name(add_on_element_name)
    assert add_on.is_a?(AddOn)
    clazz = Class.new(AddOnThought){self.site = add_on.site; self.element_name = add_on.element_name}
    t = clazz.find(1)
    assert_equal 'foo', t.body
  end
end
