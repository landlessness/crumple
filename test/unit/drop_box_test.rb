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


  test 'find person and create new thought via drop box' do
    @send_grid_mail = send_grid_mail
    
    person = people(:brian)
    
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
    assert thought.tag_list.include?('email'), 'should be tagged with "email"'
    
    assert_equal thought.body, @send_grid_mail[:text]
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_not_nil thought.project
    assert_equal project, thought.project
    assert_equal @send_grid_mail[:subject], thought.project.name
    assert @send_grid_mail[:text].include?(thought.body)
    assert thought.new_record?, 'asserting that the thought is a new record'
    assert !thought.project.new_record?, 'project should already exists'
  end
  
  test 'find person and create new thought via drop box with html email' do
    @send_grid_html_mail = send_grid_html_mail
    
    person = people(:brian)
    
    assert_not_nil @send_grid_html_mail[:to]
    assert_equal projects(:crumple).name, @send_grid_html_mail[:subject].strip!
    project = person.projects.find_by_name(@send_grid_html_mail[:subject])
    assert_not_nil project
    assert_equal projects(:crumple), project
    drop_box_name, drop_box_secret = DropBox.name_and_secret_from_email(@send_grid_html_mail[:to])
    assert_equal drop_boxes(:brians_drop_box).name, drop_box_name
    assert_equal drop_boxes(:brians_drop_box).secret, drop_box_secret
    
    assert_equal person, DropBox.find_by_name_and_secret(drop_box_name, drop_box_secret).person

    assert_equal drop_box_name, person.drop_box.name
    assert_equal drop_box_secret, person.drop_box.secret

    assert_not_nil @send_grid_html_mail[:text]
    assert_equal "\"I very rarely think in words at all. A thought comes, and I may try to express it in words afterwards,\" -Albert Einstein (Wertheimer, 1959, 213; Pais, 1982). \n\nhttp://www.psychologytoday.com/blog/imagine/201003/einstein-creative-thinking-music-and-the-intuitive-art-scientific-imagination", @send_grid_html_mail[:text]
    
    thought = DropBox.new_thought @send_grid_html_mail
    assert thought.tag_list.include?('email'), 'should be tagged with "email"'

    assert_not_nil thought.body
    assert_equal thought.body, @send_grid_html_mail[:text]
    
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_not_nil thought.project
    assert_equal project, thought.project
    assert_equal @send_grid_html_mail[:subject], thought.project.name
    assert @send_grid_html_mail[:text].include?(thought.body)
    assert thought.new_record?, 'asserting that the thought is a new record'
    assert !thought.project.new_record?
  end
  
  test 'find person and create new thought via drop box with utf8 email' do
    @send_grid_utf8_mail = send_grid_utf8_mail
    
    person = people(:brian)
    
    assert_not_nil @send_grid_utf8_mail[:to]
    assert_equal projects(:crumple).name, @send_grid_utf8_mail[:subject].strip!
    project = person.projects.find_by_name(@send_grid_utf8_mail[:subject])
    assert_not_nil project
    assert_equal projects(:crumple), project
    drop_box_name, drop_box_secret = DropBox.name_and_secret_from_email(@send_grid_utf8_mail[:to])
    assert_equal drop_boxes(:brians_drop_box).name, drop_box_name
    assert_equal drop_boxes(:brians_drop_box).secret, drop_box_secret
    
    assert_equal person, DropBox.find_by_name_and_secret(drop_box_name, drop_box_secret).person

    assert_equal drop_box_name, person.drop_box.name
    assert_equal drop_box_secret, person.drop_box.secret

    assert_not_nil @send_grid_utf8_mail[:text]
    
    thought = DropBox.new_thought @send_grid_utf8_mail
    assert thought.tag_list.include?('email'), 'should be tagged with "email"'
    
    assert_not_nil thought.body
    assert_equal thought.body, @send_grid_utf8_mail[:text]
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_not_nil thought.project
    assert_equal project, thought.project
    assert_equal @send_grid_utf8_mail[:subject], thought.project.name
    assert @send_grid_utf8_mail[:text].include?(thought.body)
    assert thought.new_record?, 'asserting that the thought is a new record'
    assert !thought.project.new_record?
  end

  test 'find person and create new thought via drop box with null error email' do
    @send_grid_nil_err_mail = send_grid_nil_err_mail
    
    person = people(:brian)
    
    assert_not_nil @send_grid_nil_err_mail[:to]
    assert_equal projects(:crumple).name, @send_grid_nil_err_mail[:subject].strip!
    project = person.projects.find_by_name(@send_grid_nil_err_mail[:subject])
    assert_not_nil project
    assert_equal projects(:crumple), project
    drop_box_name, drop_box_secret = DropBox.name_and_secret_from_email(@send_grid_nil_err_mail[:to])
    assert_equal drop_boxes(:brians_drop_box).name, drop_box_name
    assert_equal drop_boxes(:brians_drop_box).secret, drop_box_secret
    
    assert_equal person, DropBox.find_by_name_and_secret(drop_box_name, drop_box_secret).person

    assert_equal drop_box_name, person.drop_box.name
    assert_equal drop_box_secret, person.drop_box.secret

    assert_not_nil @send_grid_nil_err_mail[:text]
    
    thought = DropBox.new_thought @send_grid_nil_err_mail
    assert thought.tag_list.include?('email'), 'should be tagged with "email"'

    assert_not_nil thought.body
    assert_equal thought.body, @send_grid_nil_err_mail[:text]
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_not_nil thought.project
    assert_equal project, thought.project
    assert_equal @send_grid_nil_err_mail[:subject], thought.project.name
    assert @send_grid_nil_err_mail[:text].include?(thought.body)
    assert thought.new_record?, 'asserting that the thought is a new record'
    assert !thought.project.new_record?
  end
  
end

