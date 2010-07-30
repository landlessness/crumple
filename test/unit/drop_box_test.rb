require 'test_helper'

class DropBoxTest < ActiveSupport::TestCase
  
  setup do
    @send_grid_mail = send_grid_mail
  end
  
  test 'find person and create new thought via drop box' do
    assert_equal 1, Person.count
    assert_equal 2, DropBox.count
    person = Person.first
    
    assert_not_nil @send_grid_mail[:to]
    assert_equal projects(:exercise).name, @send_grid_mail[:subject].strip!
    project = person.projects.find_by_name(@send_grid_mail[:subject])
    assert_not_nil project
    assert_equal projects(:exercise), project
    drop_box_name, drop_box_secret = DropBox.name_and_secret_from_email(@send_grid_mail[:to])
    assert_equal drop_boxes(:brians_drop_box).name, drop_box_name
    assert_equal drop_boxes(:brians_drop_box).secret, drop_box_secret
    
    assert_equal person, DropBox.find_by_name_and_secret(drop_box_name, drop_box_secret).person

    assert_equal drop_box_name, person.drop_box.name
    assert_equal drop_box_secret, person.drop_box.secret

    thought = DropBox.new_thought @send_grid_mail
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_not_nil thought.project
    assert_equal project, thought.project
    assert_equal @send_grid_mail[:subject], thought.project.name
    assert @send_grid_mail[:text].include?(thought.body)
    assert :drop_box, thought.state
    assert thought.new_record?
    assert !thought.project.new_record?
  end
  
end
