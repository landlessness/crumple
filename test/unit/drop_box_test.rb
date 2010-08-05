require 'test_helper'

class DropBoxTest < ActiveSupport::TestCase
  def setup
    @person = people(:fred)
  end
  
  test "a drop_box with a person and a valid name is valid" do
    assert @person.drop_boxes.create!(:name => 'fred'), 'drop_box should create smoothly'
  end
    
  test "all drop boxes must have a valid name" do
    e = assert_raise(ActiveRecord::RecordInvalid) {  
      d = @person.drop_boxes.create! :name => "\"fr+e$d"
    }
    assert_match /Validation failed: Name is invalid/, e.message
  end
  
  test "all thoughts must have a person" do
    e = assert_raise(ActiveRecord::RecordInvalid) {  
      t = DropBox.create! :name => 'fred'
    }
    assert_match /Validation failed: Person can't be blank/, e.message
  end

end

