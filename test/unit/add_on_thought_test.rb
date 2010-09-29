require 'test_helper'

class AddOnThoughtTest < ActiveSupport::TestCase
  def setup
    @person = people(:brian)
    @music_add_on = add_ons(:music_notation)
    @abc_notation = %(X:1
    T:Grace notes
    M:6/8
    K:C
    {g}A3 A{g}AA|{gAGAG}A3 {g}A{d}A{e}A|])
  end
  def test_validity
    todo_add_on = add_ons(:todo_list)

    assert @person.add_on_thoughts.new(:add_on => @music_add_on).valid?, "everything looked good. what's missing?"

    assert !@person.add_on_thoughts.new(:add_on => todo_add_on).valid?, "not valid because wrong type of add on"
    assert_raise AddOnTypeMismatch do
      AddOnThought.subclazz_new(:add_on => todo_add_on)
    end
    assert !AddOnThought.new.valid?, 'not valid because no person or add-on included'
    assert !AddOnThought.new(:add_on => @music_add_on).valid?, 'not valid because no person included'
    assert !@person.add_on_thoughts.new.valid?, 'not valid because no add on included'
  end
  def test_foreign_ids
    t = AddOnThought.subclazz_new :add_on => @music_add_on
    assert t.respond_to?(:add_on_id), 'should have method for add_on_id'
    assert t.respond_to?(:add_on_thought_resource_id), 'should have method for add_on_thought_resource_identifier'
  end
  def test_new_thought_from_add_on_shortcut
    t = AddOnThought.subclazz_new :add_on => @music_add_on
    assert t.is_a?(MusicNotationThought)
    assert_equal @music_add_on, t.add_on
  end
  def test_new_thought_from_add_on_long
    t = AddOnThought.subclazz(@music_add_on).new :add_on => @music_add_on
    assert t.is_a?(MusicNotationThought)
    assert_equal @music_add_on, t.add_on
  end
  def test_create_thought_from_add_on_long
    t = AddOnThought.subclazz(@music_add_on).create :add_on => @music_add_on
    assert t.is_a?(MusicNotationThought)
    assert_equal @music_add_on, t.add_on
  end
  def test_create_thought_from_add_on_shortcut
    t = create_music_thought
    assert t.is_a?(MusicNotationThought)
    assert_equal @music_add_on, t.add_on
  end
  def test_create
    t = create_music_thought
    assert_equal @abc_notation, t.add_on_thought_resource.body
  end
  def test_find
    t = create_music_thought
    assert t.add_on_thought_resource_clazz.find(t.add_on_thought_resource.to_param).valid?
  end
  def test_update
    t = create_music_thought
    updated_abc_notation = %(X:1
    T:Updated Grace notes
    M:6/8
    K:C
    {g}A3 A{g}AA|{gAGAG}A3 {g}A{d}A{e}A|])
    t.update_attributes(:music_notation_thought => {:body => updated_abc_notation})
    assert_equal updated_abc_notation, t.add_on_thought_resource.body
  end
  def test_delete
    t = create_music_thought
    t.add_on_thought_resource.destroy
    assert_raise ActiveRecord::RecordNotFound do
      AddOnThought.find(t.to_param)
    end
  end
  protected
  def create_music_thought
    AddOnThought.subclazz_create :add_on => @music_add_on, :music_notation_thought => {:body => @abc_notation}    
  end
end

