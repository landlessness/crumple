class ApplicationController < ActionController::Base
  before_filter :authenticate_person!
  before_filter :check_drop_box
  
  protect_from_forgery
  layout 'application'
  
  def check_drop_box
    @drop_box_count = current_person.thoughts.with_state(:drop_box).count if person_signed_in?
  end
  
  protected
  def log_headers
    Rails.logger.fatal 'Headers'
    for header in request.env.select {|k,v| k.match("^HTTP.*")}
      Rails.logger.fatal "#{header[0].split('_',2)[1]} #{header[1]}"
    end
  end  
end
