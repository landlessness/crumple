# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crumple::Application.initialize!

Mime::Type.register "sendgrid/email", :send_grid