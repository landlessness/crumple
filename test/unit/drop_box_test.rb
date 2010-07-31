require 'test_helper'

class DropBoxTest < ActiveSupport::TestCase
  
  test 'find person and create new thought via drop box' do
    @send_grid_mail = send_grid_mail
    
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
    assert_equal thought.body, @send_grid_mail[:text]
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_not_nil thought.project
    assert_equal project, thought.project
    assert_equal @send_grid_mail[:subject], thought.project.name
    assert @send_grid_mail[:text].include?(thought.body)
    assert thought.new_record?, 'asserting that the thought is a new record'
    assert !thought.project.new_record?
  end
  
  test 'find person and create new thought via drop box with html email' do
    @send_grid_html_mail = send_grid_html_mail
    
    assert_equal 1, Person.count
    assert_equal 2, DropBox.count
    person = Person.first
    
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
  
  
end

