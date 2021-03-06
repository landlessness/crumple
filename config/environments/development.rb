Crumple::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # for devise mailer
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  config.top_level_domain = 'localhost:3000'
  config.active_support.deprecation = :log 
  # for STI for AddOns
  %w[add_on thought_add_on container_add_on].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
  # for STI for Thoughts
  # %w[thought add_on_thought plain_text_thought].each do |c|
  #   require_dependency File.join("app","models","#{c}.rb")
  # end
end
