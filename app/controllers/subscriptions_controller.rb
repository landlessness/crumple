class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Subscription.all
  end
  
  def show
    @subscription = Subscription.find(params[:id])
  end
  
  def new
    @subscription = Subscription.new
  end
  
  def create
    @pricing_plan = PricingPlan.find(params[:pricing_plan_id])
    @subscription = @pricing_plan.subscriptions.new(params[:subscription])
    @subscription.person = current_person
    if @subscription.save
      flash[:notice] = "Successfully subscribed."
      redirect_to add_on_url(@pricing_plan.add_on)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @subscription = Subscription.find(params[:id])
  end
  
  def update
    @subscription = Subscription.find(params[:id])
    if @subscription.update_attributes(params[:subscription])
      flash[:notice] = "Successfully updated subscription."
      redirect_to @subscription
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    flash[:notice] = "Successfully canceled subscription."
    redirect_to @subscription.pricing_plan.add_on
  end
end
