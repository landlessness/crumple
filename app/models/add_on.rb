class AddOn < ActiveRecord::Base
  belongs_to :developer, :class_name => 'Person', :foreign_key => 'person_id'
  has_many :pricing_plans
  has_many :screen_shots
  accepts_nested_attributes_for :pricing_plans, :allow_destroy => true
end
