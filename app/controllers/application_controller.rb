class ApplicationController < ActionController::Base
  before_filter :authenticate_person!
  before_filter :check_dropbox
  
  protect_from_forgery
  layout 'application'
  
  def check_dropbox
    @dropbox_count = current_person.thoughts.with_state(:dropbox).count
  end
end
