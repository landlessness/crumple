require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "person create creates dropbox" do
    p = Person.create! :email => 'brian@foobar.net', :password => 'password'
    assert_equal 'brian', p.dropboxes.first.name
  end
end
