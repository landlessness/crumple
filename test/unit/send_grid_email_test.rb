require 'test_helper'
require 'send_grid_email_test_helper'

class SendGridEmailTest < ActiveSupport::TestCase

  setup do
    @send_grid_email = send_grid_emails(:one)
    @project = projects(:crumple)
  end

  test 'cannot find drop box email' do
    m = SendGridEmail.create send_grid_emails(:bogus_email_address).attributes
    assert !m.assigned_drop_box?
  end

  test 'create a send grid email' do
    assert_not_nil @send_grid_email
    assert_difference('SendGridEmail.count') do    
      m = SendGridEmail.create @send_grid_email.attributes
    end
  end
  
  test 'create a send grid email w/o subject' do
    assert_difference('SendGridEmail.count') do    
      m = SendGridEmail.create send_grid_emails(:without_subject).attributes
    end
  end
  
  test 'create a send grid email w/o text' do
    assert_difference('SendGridEmail.count') do    
      m = SendGridEmail.create send_grid_emails(:without_text).attributes
    end
  end
  
  test 'create a send grid email w/o text or subject' do
    assert_difference('SendGridEmail.count') do    
      m = SendGridEmail.create send_grid_emails(:without_text_or_subject).attributes
    end
  end

  test 'creating a send grid email creates a thought and puts it in the drop box' do
    m = nil
    assert_not_nil @project
    assert_difference('SendGridEmail.count') do    
      m = SendGridEmail.create @send_grid_email.attributes
    end
    assert m.assigned_drop_box?,'should have found the drop box.'
    assert m.thought.body.include?(m.subject), 'email subject should be in the thought body'
    assert m.thought.body.include?('this is a new thought'), 'thought should include the original email text'
    assert !m.thought.body.include?('tags: detroit hackerspace'), 'thought body should NOT include the original tags'
    assert !m.thought.body.include?('project: Crumple'), 'thought body should NOT include the project'
    assert m.thought.in_drop_box?, 'thought should be created and in drop box.'
    assert m.thought.tags_list.include?('hackerspace'), 'should include tag "hackerspace"'
    assert m.thought.tags_list.include?('detroit'), 'should include tag "detroit"'
    assert_not_nil m.thought.project
    assert_equal 'Crumple', m.thought.project.name
  end
  
  test 'find person and create new thought via drop box' do
    person = people(:brian)

    email_params = SendGridEmail.remove_unknown_attributes send_grid_mail_fixture
    assert_not_nil email_params[:to]

    drop_box_name, drop_box_secret = DropBox.name_and_secret_from_email_address(email_params[:to])
    assert_equal drop_boxes(:brians_drop_box).name, drop_box_name
    assert_equal drop_boxes(:brians_drop_box).secret, drop_box_secret
    
    drop_box = DropBox.find_by_name_and_secret(drop_box_name, drop_box_secret)
    assert_equal person, drop_box.person

    assert_equal drop_box_name, drop_box.name
    assert_equal drop_box_secret, drop_box.secret

    email = SendGridEmail.create email_params
    thought = email.thought
    assert thought.tags_list.include?('foo'), 'should be tagged with "foo"'
    assert thought.tags_list.include?('bar'), 'should be tagged with "bar"'
        
    assert_not_nil thought.person
    assert_equal person, thought.person
    assert_equal drop_box, email.drop_box
    assert_not_nil thought.project
    assert_equal projects(:crumple), thought.project
  end

end
