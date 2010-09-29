require 'test_helper'

class AddOnThoughtResourceTest < ActiveSupport::TestCase
  def setup
    @add_on = add_ons(:music_notation)
  end
  def test_should_be_valid
    assert AddOnThoughtResource.new.valid?
  end
  
  def test_subclazz_find
    subclazz = AddOnThoughtResource.subclazz_for(@add_on)
    assert_equal ActiveResource::Formats::JsonFormat, subclazz.format
    assert_equal 'MusicNotationThoughtResource', subclazz.name
    thought = subclazz.find 1
    assert_match /Speed the Plough/, thought.body
  end
  
  def test_subclazz_create
    subclazz = AddOnThoughtResource.subclazz_for(@add_on)
    thought = subclazz.create :body => 'danny boy'
    assert_match /danny boy/, thought.body
    assert_match /^\d+$/, thought.to_param
  end

  def test_subclazz_destroy
    thought = AddOnThoughtResource.subclazz_for(@add_on).create(:body => 'danny boy')
    thought.destroy
    assert_raise ActiveResource::ResourceNotFound do
      thought.reload
    end
  end
  
  def test_find_by_add_on_and_id
    add_on_element_name = 'music_notation_thought'
    add_on = AddOn.find_by_element_name(add_on_element_name)
    assert add_on.is_a?(AddOn)
    subclazz = Class.new(AddOnThoughtResource){self.site = add_on.site; self.element_name = add_on.element_name}
    assert_equal ActiveResource::Formats::JsonFormat, subclazz.format
    thought = subclazz.find(1)
    assert_match /Speed the Plough/, thought.body
  end
end
