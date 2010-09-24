class AddOnsController < ApplicationController
  def index
    @add_ons = AddOn.all
  end
  
  def show
    @add_on = AddOn.find(params[:id])
  end
  
  def new
    @add_on = AddOn.new
  end
  
  def create
    @add_on = marshal_type(params[:add_on],AddOn,:developer => current_person)
    if @add_on.save
      flash[:notice] = "Successfully created add on."
      redirect_to add_on_path(@add_on)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @add_on = AddOn.find(params[:id])
  end
  
  def update
    @add_on = AddOn.find(params[:id])
    if @add_on.update_attributes(params[:add_on])
      flash[:notice] = "Successfully updated add on."
      redirect_to @add_on
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @add_on = AddOn.find(params[:id])
    @add_on.destroy
    flash[:notice] = "Successfully destroyed add on."
    redirect_to add_ons_url
  end
end
