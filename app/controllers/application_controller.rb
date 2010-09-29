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
  def marshal_type(params, base_class = nil)
    type = params.delete(:type)
    if base_class
      if base_class.descendants.include? type.constantize
        new_type(type,params)
      end
    else
      new_type(type,params)
    end
  end
  def new_type(type, params={})
    logger.info 'new_type params.to_yaml: ' + params.to_yaml
    
    type.constantize.new(params)    
  end
end
