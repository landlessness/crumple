# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crumple::Application.initialize!

Crumple::Application.configure do
  config.product_name = 'Crumple'
  config.product_tag_line = 'A notebook'
  config.product_version = 'proto'
end
