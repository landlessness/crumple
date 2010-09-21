require 'test_helper'

class ThoughtTest < ActiveSupport::TestCase
  
  def setup
    @person = people(:brian)
  end
  
  test 'taggings' do
    assert t = @person.thoughts.create!(:body => 'this is a cool thought.', :tags_list => 'foo bar baz'), 'thought should create smoothly'
    assert_equal 'foo bar baz', t.tags_list
    t.update_attributes(:tags_list => 'red white blue')
    assert_equal 'red white blue', t.reload.tags_list
  end
  
  test 'taggings concat' do
    assert t = @person.thoughts.create!(:body => 'this is a cool thought.', :tags_list => 'foo bar baz'), 'thought should create smoothly'
    assert_equal 'foo bar baz', t.tags_list
    t.update_attributes(:tags_list_concat => 'red white blue')
    assert_equal 'foo bar baz red white blue', t.reload.tags_list
    assert_equal '', t.tags_list_concat
  end
  
  test "a thought with a person and a body is valid" do
    assert @person.thoughts.create!(:body => 'this is a cool thought.'), 'thought should create smoothly'
  end
    
  test "create with a given state" do
    assert t = @person.thoughts.create!(:body => 'this is a cool thought.', :state_event => :put_in_drop_box), 'thought should create smoothly'
    assert t.in_drop_box?, 'should create thought in drop_box state'
  end

  test "all thoughts must have a body" do
    e = assert_raise(ActiveRecord::RecordInvalid) {  
      @person.thoughts.create! :body => nil
    }
    assert_match /Validation failed: Body can't be blank/, e.message
  end
  
  test "all thoughts must have a person" do
    e = assert_raise(ActiveRecord::RecordInvalid) {  
      t = Thought.create! :body => 'this is a cool thought'
    }
    assert_match /Validation failed: Person can't be blank/, e.message
  end

  test "tags are assigned to thoughts and have owners" do
    new_tags_list = %w(blue green orange)
    orig_tags = %w(foo bar)
    
    assert_equal orig_tags, @person.tags.map(&:name)
    t = @person.thoughts.create :body => 'this is a thought with tags', :tags_list => new_tags_list.join(' ')
    
    assert_equal ["bar", "blue", "foo", "green", "orange"], @person.tags.reload.map(&:name).sort
    assert_equal new_tags_list.join(' '), t.tags_list
  end
end
