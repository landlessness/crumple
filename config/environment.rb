# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crumple::Application.initialize!

Crumple::Application.configure do
  config.product_name = 'crumple'
  config.product_tag_line = 'a notebook'
  config.product_version = 'proto'
end
