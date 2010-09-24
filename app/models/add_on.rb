class AddOn < ActiveRecord::Base
  belongs_to :developer, :class_name => 'Person', :foreign_key => 'person_id'
  has_many :pricing_plans
  has_many :screen_shots
end
