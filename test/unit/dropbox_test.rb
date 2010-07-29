require 'test_helper'

class DropboxTest < ActiveSupport::TestCase
  test 'find person via drop box' do
    assert_equal 1, Person.count
    assert_equal 2, Dropbox.count
    person = Person.first
    assert_equal 1, person.dropboxes.count
    dropbox_name = 'brian'
    dropbox_secret = '12344321'
    assert_equal dropbox_name, person.dropboxes.first.name
    assert_equal dropbox_secret, person.dropboxes.first.secret
    
    gm = 'gmail.mail'
    mail = Mail.read(email_path(gm))

    assert_equal 'brian+12344321@crumpleit.com', mail.to.first
    
    thought = Dropbox.process_email mail
    assert_equal person, thought.person
    assert_equal mail.subject, thought.project.name
    assert mail.body.include?(thought.body)
    assert :dropbox, thought.state
  end
  
end
