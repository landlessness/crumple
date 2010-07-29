ENV["RAILS_ENV"] = "test"
FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def email_path(action)
    "#{FIXTURES_PATH}/mail_samples/#{action}"
  end

  def read_fixture(action)
    IO.readlines(email_path(action))
  end

end
