class ScreenshotsController < ApplicationController
  def index
    @screenshots = Screenshot.all
  end
  
  def show
    @screenshot = Screenshot.find(params[:id])
  end
  
  def new
    @screenshot = Screenshot.new
  end
  
  def create
    @screenshot = Screenshot.new(params[:screenshot])
    if @screenshot.save
      flash[:notice] = "Successfully created screenshot."
      redirect_to @screenshot
    else
      render :action => 'new'
    end
  end
  
  def edit
    @screenshot = Screenshot.find(params[:id])
  end
  
  def update
    @screenshot = Screenshot.find(params[:id])
    if @screenshot.update_attributes(params[:screenshot])
      flash[:notice] = "Successfully updated screenshot."
      redirect_to @screenshot
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @screenshot = Screenshot.find(params[:id])
    @screenshot.destroy
    flash[:notice] = "Successfully destroyed screenshot."
    redirect_to screenshots_url
  end
end
