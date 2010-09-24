require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = people(:brian)
  end

  def test_person_creates_drop_box
    p = Person.create! :email => 'brian@foobar.net', :password => 'password'
    assert_match /^brian\d{10}$/, p.drop_box.name
  end
  def test_add_on_installed_check
    add_on = add_ons(:music_notation)
    assert !@person.add_on_installed?(add_on), 'should NOT have an add-on installed.'
    @person.installations.create :add_on => add_on
    assert @person.add_on_installed?(add_on), 'should have an add-on installed.'    
  end
  def test_person_equality
    add_on = add_ons(:music_notation)
    assert @person == add_on.developer
  end
end
