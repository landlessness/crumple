class AddOnThoughtsController < ApplicationController  
  def index    
  end
  def show
    add_on_thought_subclazz = AddOnThought.subclazz_for(params[:add_on] + '_thought')
    @thought = add_on_thought_subclazz.find(params[:id])
  end
end