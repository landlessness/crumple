# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Crumple::Application.initialize!

Crumple::Application.configure do
end

Haml::Template.options[:format] = :html5
