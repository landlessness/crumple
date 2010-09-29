require 'test_helper'

class AddOnTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AddOn.new.valid?
  end
  def test_add_on_types
    assert add_ons(:music_notation).is_a?(ThoughtAddOn)
    assert add_ons(:todo_list).is_a?(ContainerAddOn)
  end
  def test_mixed_case_name
    a = add_ons(:music_notation)
    assert_equal 'Music Notation', a.name
    assert_equal 'http://localhost:3001', a.site
    assert_equal 'music_notation_thought', a.element_name
    a = add_ons(:textile)
    assert_equal 'Textile', a.name
    assert_equal 'http://localhost:3001', a.site
    assert_equal 'textile_thought', a.element_name
  end
  def test_element_class_name
    a = add_ons(:music_notation)
    assert_equal 'MusicNotationThought', a.element_class_name
    a = add_ons(:textile)    
    assert_equal 'TextileThought', a.element_class_name
  end
  def test_belongs_to_person
    p = people(:brian)
    a = p.developed_add_ons.create :name => 'Drawing'
    assert_equal p, a.developer
    assert p.developed_add_ons.include?(a), 'new add on should be in developers list of add-ons'
  end
  def test_accepts_nested_attributes
    p = people(:brian)
    assert AddOn.new(:developer => p, :name => 'test nested', :pricing_plans_attributes => [{:name => 'free'},{:name => 'bronze'},{:name => 'silver'},{:name => 'gold'}]).valid?
  end
end
