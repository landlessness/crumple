require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "person creates drop box" do
    p = Person.create! :email => 'brian@foobar.net', :password => 'password'
    assert_equal 'brian', p.drop_box.name
  end
end
