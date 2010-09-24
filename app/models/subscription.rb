class Subscription < ActiveRecord::Base
  belongs_to :person
  belongs_to :pricing_plan
end
