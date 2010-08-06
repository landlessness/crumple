require 'test_helper'

class ThoughtTest < ActiveSupport::TestCase
  
  def setup
    @person = people(:brian)
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
    
    tags = %w(blue green orange)
    
    assert @person.owned_tags.empty?, 'person should not own any tags at the beginning'
    t = @person.thoughts.create :body => 'this is a thought with tags'
    @person.tag(t, :with => tags.join(' '), :on => :tags)
    
    assert_equal tags, @person.owned_tags.map(&:name)
  end
end
