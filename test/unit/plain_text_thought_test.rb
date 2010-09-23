require 'test_helper'

class PlainTextThoughtTest < ActiveSupport::TestCase
  
  def setup
    @person = people(:brian)
  end
  
  test 'taggings' do
    assert t = @person.plain_text_thoughts.create!(:body => 'this is a cool plain_text_thought.', :tags_list => 'foo bar baz'), 'plain_text_thought should create smoothly'
    assert_equal 'foo bar baz', t.tags_list
    t.update_attributes(:tags_list => 'red white blue')
    assert_equal 'red white blue', t.reload.tags_list
  end
  
  test 'taggings concat' do
    assert t = @person.plain_text_thoughts.create!(:body => 'this is a cool plain_text_thought.', :tags_list => 'foo bar baz'), 'plain_text_thought should create smoothly'
    assert_equal 'foo bar baz', t.tags_list
    t.update_attributes(:tags_list_concat => 'red white blue')
    assert_equal 'foo bar baz red white blue', t.reload.tags_list
    assert_equal '', t.tags_list_concat
  end
  
  test "a plain_text_thought with a person and a body is valid" do
    assert @person.plain_text_thoughts.create!(:body => 'this is a cool plain_text_thought.'), 'plain_text_thought should create smoothly'
  end
    
  test "create with a given state" do
    assert t = @person.plain_text_thoughts.create!(:body => 'this is a cool plain_text_thought.', :state_event => :put_in_drop_box), 'plain_text_thought should create smoothly'
    assert t.in_drop_box?, 'should create plain_text_thought in drop_box state'
  end

  test "all plain_text_thoughts must have a body" do
    e = assert_raise(ActiveRecord::RecordInvalid) {  
      @person.plain_text_thoughts.create! :body => nil
    }
    assert_match /Validation failed: Body can't be blank/, e.message
  end
  
  test "all plain_text_thoughts must have a person" do
    e = assert_raise(ActiveRecord::RecordInvalid) {  
      t = PlainTextThought.create! :body => 'this is a cool plain_text_thought'
    }
    assert_match /Validation failed: Person can't be blank/, e.message
  end

  test "tags are assigned to plain_text_thoughts and have owners" do
    new_tags_list = %w(blue green orange)
    orig_tags = %w(foo bar)
    
    assert_equal orig_tags, @person.tags.map(&:name)
    t = @person.plain_text_thoughts.create :body => 'this is a plain_text_thought with tags', :tags_list => new_tags_list.join(' ')
    
    assert_equal ["bar", "blue", "foo", "green", "orange"], @person.tags.reload.map(&:name).sort
    assert_equal new_tags_list.join(' '), t.tags_list
  end
end
