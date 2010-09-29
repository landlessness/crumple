class ApplicationController < ActionController::Base
  before_filter :authenticate_person!
  before_filter :check_drop_box
  helper :layout
  
  protect_from_forgery
  layout 'application'

  # this hack allows the user's input before being loged in to carry on after signing in
  def authenticate_person!
    if !person_signed_in? && request.post?
      p = request.path_parameters.symbolize_keys
      if p[:controller] == 'thoughts' && p[:action] == 'create'
        scope = Devise::Mapping.find_scope!(Person)
        session[:"#{scope}_return_to"] = auto_create_thoughts_path(:thought => params[:thought])
      end
    end    
    super
  end
  
  def check_drop_box
    @drop_box_count = current_person.thoughts.with_state(:in_drop_box).count if person_signed_in?
  end
  protected
  def marshal_type(params)
    type_new(params.delete(:type),params)
  end
  def type_new(type, params={})
    type.constantize.new(params)    
  end
end
