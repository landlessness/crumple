require 'test_helper'

class ThoughtTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "a thought with a person and a body is valid" do
    p = Person.first
    assert p.thoughts.create!(:body => 'this is a cool thought.'), 'thought should create smoothly'
  end
    
  test "all thoughts must have a body" do
    p = Person.first
    e = assert_raise(ActiveRecord::RecordInvalid) {  
      p.thoughts.create! :body => nil
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
