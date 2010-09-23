require 'test_helper'

class ThoughtTest < ActiveSupport::TestCase
  
  def setup
    @person = people(:brian)
  end
  
  test "a base thought wont be made because it doesnt have a serach field" do
    e = assert_raise(NoMethodError) {
      @person.thoughts.create!(:body => 'this is a cool thought.')
    }
    assert_match /search_text/, e.message
  end
end
