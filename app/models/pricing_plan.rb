class PricingPlan < ActiveRecord::Base
  belongs_to :add_on
  has_many :subscriptions, :dependent => :destroy
end
