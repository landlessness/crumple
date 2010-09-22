class AddOnThoughtsController < ApplicationController  
  def index    
  end
  def show
    @thought = AddOnThought.find_by_add_on_and_id(params[:add_on] + '_thought', params[:id])
  end
end