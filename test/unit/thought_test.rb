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

end
