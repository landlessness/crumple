require 'test_helper'

class DropBoxTest < ActiveSupport::TestCase
  test 'find person via drop box' do
    assert_equal 1, Person.count
    assert_equal 2, DropBox.count
    person = Person.first
    drop_box_name = 'brian'
    drop_box_secret = '12344321'
    assert_equal drop_box_name, person.drop_box.name
    assert_equal drop_box_secret, person.drop_box.secret
    
    gm = 'gmail.mail'
    mail = Mail.read(email_path(gm))

    assert_equal 'brian+12344321@crumpleit.com', mail.to.first
    
    thought = DropBox.process_email mail
    assert_equal person, thought.person
    assert_equal mail.subject, thought.project.name
    assert mail.body.include?(thought.body)
    assert :drop_box, thought.state
  end
  
end
