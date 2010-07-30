class ApplicationController < ActionController::Base
  before_filter :authenticate_person!
  before_filter :check_drop_box
  
  protect_from_forgery
  layout 'application'
  
  def check_drop_box
    @drop_box_count = current_person.thoughts.with_state(:drop_box).count
  end
end
