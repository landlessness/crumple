class PricingPlansController < ApplicationController
  def index
    @pricing_plans = PricingPlan.all
  end
  
  def show
    @pricing_plan = PricingPlan.find(params[:id])
  end
  
  def new
    @pricing_plan = PricingPlan.new
  end
  
  def create
    @pricing_plan = PricingPlan.new(params[:pricing_plan])
    if @pricing_plan.save
      flash[:notice] = "Successfully created pricing plan."
      redirect_to @pricing_plan
    else
      render :action => 'new'
    end
  end
  
  def edit
    @pricing_plan = PricingPlan.find(params[:id])
  end
  
  def update
    @pricing_plan = PricingPlan.find(params[:id])
    if @pricing_plan.update_attributes(params[:pricing_plan])
      flash[:notice] = "Successfully updated pricing plan."
      redirect_to @pricing_plan
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @pricing_plan = PricingPlan.find(params[:id])
    @pricing_plan.destroy
    flash[:notice] = "Successfully destroyed pricing plan."
    redirect_to pricing_plans_url
  end
end
