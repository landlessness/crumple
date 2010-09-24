class AddOn < ActiveRecord::Base
  belongs_to :developer, :class_name => 'Person', :foreign_key => 'person_id'
  has_many :pricing_plans, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
  
  accepts_nested_attributes_for :pricing_plans
end
